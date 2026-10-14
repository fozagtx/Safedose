import 'package:flutter/material.dart' hide Ink;
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/page_header.dart';

class MembersView extends StatefulWidget {
  final CircleSummary circle;
  const MembersView({super.key, required this.circle});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
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
    return ListView(
      padding: AppShell.pagePadding(context),
      children: [
        PageHeader(
          title: 'Care circle',
          subtitle:
              'Everyone who can see and log doses for '
              '${widget.circle.child.name}.',
        ),
        FutureBuilder<List<CareMember>>(
          future: _members,
          builder: (context, snap) {
            if (snap.hasError) {
              return Text(
                errorText(snap.error!),
                style: const TextStyle(color: Ink.muted),
              );
            }
            if (!snap.hasData) {
              return const Padding(
                padding: EdgeInsets.all(48),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final members = snap.data!;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Ink.line),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < members.length; i++) ...[
                      if (i > 0) const Divider(),
                      _MemberRow(
                        member: members[i],
                        canRemove: isOwner && members[i].role != CareRole.owner,
                        onRemove: () async {
                          try {
                            await client.circle.revoke(members[i].id!);
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Lights.red,
                                  content: Text(errorText(e)),
                                ),
                              );
                            }
                          }
                          setState(() => _members = _load());
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MemberRow extends StatelessWidget {
  final CareMember member;
  final bool canRemove;
  final VoidCallback onRemove;

  const _MemberRow({
    required this.member,
    required this.canRemove,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Ink.soft,
            child: Text(
              member.displayName.isEmpty
                  ? '?'
                  : member.displayName[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Ink.ink,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Ink.ink,
                  ),
                ),
                Text(
                  _MembersViewState._role(member),
                  style: const TextStyle(fontSize: 13, color: Ink.muted),
                ),
              ],
            ),
          ),
          if (canRemove)
            OutlinedButton(onPressed: onRemove, child: const Text('Remove')),
        ],
      ),
    );
  }
}
