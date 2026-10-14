import 'package:flutter/material.dart' hide Ink;
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/page_header.dart';

/// The audit trail, accepted and refused. Sitters see their shift only.
class HistoryView extends StatefulWidget {
  final CircleSummary circle;
  const HistoryView({super.key, required this.circle});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late Future<List<DoseEvent>> _events = _load();

  Future<List<DoseEvent>> _load() =>
      client.history.list(widget.circle.child.id!);

  Future<void> _reload() async {
    setState(() => _events = _load());
    await _events;
  }

  @override
  Widget build(BuildContext context) {
    final sitter = widget.circle.me.role == CareRole.sitter;
    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView(
        padding: AppShell.pagePadding(context),
        children: [
          PageHeader(
            title: 'History',
            subtitle:
                'Every dose given or refused, newest first.'
                '${sitter ? ' You see your shift only.' : ''}',
            actions: [
              OutlinedButton.icon(
                onPressed: _reload,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
              ),
            ],
          ),
          FutureBuilder<List<DoseEvent>>(
            future: _events,
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
              final events = snap.data!;
              if (events.isEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Ink.line),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(32),
                  child: const Text(
                    'Nothing logged yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Ink.muted),
                  ),
                );
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Ink.line),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < events.length; i++) ...[
                        if (i > 0) const Divider(),
                        _EventRow(events[i]),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final DoseEvent e;
  const _EventRow(this.e);

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label · ${e.medicineName} ${e.doseText}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Ink.ink,
                  ),
                ),
                Text(
                  '${e.caregiverName} · ${formatDateTime(e.at)}',
                  style: const TextStyle(fontSize: 13, color: Ink.muted),
                ),
                if (e.reason != null)
                  Text(
                    e.reason!,
                    style: const TextStyle(fontSize: 13, color: Ink.ink),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
