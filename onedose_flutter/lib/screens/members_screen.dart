import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';

class MembersScreen extends StatefulWidget {
  final CircleSummary circle;
  const MembersScreen({super.key, required this.circle});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late Future<List<CareMember>> _members = _load();

  Future<List<CareMember>> _load() =>
      client.circle.members(widget.circle.child.id!);

  static String _role(CareMember m) => switch (m.role) {
    CareRole.owner => 'Parent',
    CareRole.coparent => 'Co-parent',
    CareRole.sitter =>
      'Sitter · ${formatDateTime(m.shiftStart)} – ${formatTime(m.shiftEnd)}',
  };

  @override
  Widget build(BuildContext context) {
    final isOwner = widget.circle.me.role == CareRole.owner;
    return Scaffold(
      appBar: AppBar(title: const Text('Care circle')),
      body: FutureBuilder<List<CareMember>>(
        future: _members,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(errorText(snap.error!)));
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              for (final m in snap.data!)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(m.displayName),
                  subtitle: Text(_role(m)),
                  trailing: isOwner && m.role != CareRole.owner
                      ? TextButton(
                          onPressed: () async {
                            await client.circle.revoke(m.id!);
                            setState(() => _members = _load());
                          },
                          child: const Text('Remove'),
                        )
                      : null,
                ),
            ],
          );
        },
      ),
    );
  }
}
