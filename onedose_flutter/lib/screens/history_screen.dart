import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';

/// The audit trail, accepted and refused. Sitters see their shift only.
class HistoryScreen extends StatefulWidget {
  final CircleSummary circle;
  const HistoryScreen({super.key, required this.circle});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<DoseEvent>> _events = _load();

  Future<List<DoseEvent>> _load() =>
      client.history.list(widget.circle.child.id!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _events = _load());
          await _events;
        },
        child: FutureBuilder<List<DoseEvent>>(
          future: _events,
          builder: (context, snap) {
            if (snap.hasError) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(errorText(snap.error!)),
                  ),
                ],
              );
            }
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final events = snap.data!;
            if (events.isEmpty) {
              return ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Nothing logged yet.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              itemCount: events.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) => _EventTile(events[i]),
            );
          },
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final DoseEvent e;
  const _EventTile(this.e);

  @override
  Widget build(BuildContext context) {
    final (icon, color, label) = switch (e.outcome) {
      DoseOutcome.accepted when e.undoneAt != null => (
        Icons.undo,
        Lights.unknown,
        'Given, then undone',
      ),
      DoseOutcome.accepted => (Icons.check_circle, Lights.green, 'Given'),
      DoseOutcome.override => (Icons.warning, Lights.red, 'Override'),
      DoseOutcome.refusedInterval => (Icons.block, Lights.amber, 'Refused'),
      DoseOutcome.refusedDailyMax => (Icons.block, Lights.red, 'Refused'),
      DoseOutcome.undone => (Icons.undo, Lights.unknown, 'Undo'),
    };
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text('$label · ${e.medicineName} ${e.doseText}'),
      subtitle: Text(
        '${e.caregiverName} · ${formatDateTime(e.at)}'
        '${e.reason == null ? '' : '\n${e.reason}'}',
      ),
      isThreeLine: e.reason != null,
    );
  }
}
