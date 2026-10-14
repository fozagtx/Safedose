import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/safety_footer.dart';
import 'history_screen.dart';
import 'invite_screen.dart';
import 'medicine_form.dart';
import 'members_screen.dart';

/// The child's card: every medicine, live, with a "Give" button each.
class CircleScreen extends StatefulWidget {
  final CircleSummary circle;
  final VoidCallback onLeft;
  const CircleScreen({super.key, required this.circle, required this.onLeft});

  @override
  State<CircleScreen> createState() => _CircleScreenState();
}

class _CircleScreenState extends State<CircleScreen> {
  StreamSubscription<CircleEvent>? _sub;
  Timer? _retry;
  Timer? _refresh;

  /// Null while we have no fresh answer from the server; the cards then show
  /// "Can't check" rather than a stale green.
  List<MedicineStatus>? _statuses;
  bool _connected = false;
  bool _shiftEnded = false;
  String? _shiftMessage;
  bool _demo = false;
  final _alerts = <CircleEvent>[];
  final _busy = <int>{};

  int get _childId => widget.circle.child.id!;
  bool get _isOwner => widget.circle.me.role == CareRole.owner;

  @override
  void initState() {
    super.initState();
    _connect();
    client.child.demoMode().then((d) {
      if (mounted) setState(() => _demo = d);
    }, onError: (_) {});
  }

  @override
  void dispose() {
    _sub?.cancel();
    _retry?.cancel();
    _refresh?.cancel();
    super.dispose();
  }

  void _connect() {
    _sub?.cancel();
    _sub = client.circle
        .watch(_childId)
        .listen(_onEvent, onError: _onStreamError, onDone: _onStreamDone);
  }

  void _onEvent(CircleEvent e) {
    if (!mounted) return;
    setState(() {
      _connected = true;
      if (e.statuses != null) _statuses = e.statuses;
      if (e.type == CircleEventType.alert) _alerts.insert(0, e);
      if (e.type == CircleEventType.shiftEnded) {
        _shiftEnded = true;
        _shiftMessage = e.message;
      }
    });
    if (e.type == CircleEventType.doseRefused ||
        e.type == CircleEventType.doseAccepted) {
      final msg = e.message;
      if (msg != null && e.event?.caregiverId != widget.circle.me.userId) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
    _scheduleRefresh();
  }

  /// When an amber or red light is due to turn green, ask the server again.
  void _scheduleRefresh() {
    _refresh?.cancel();
    final times =
        (_statuses ?? [])
            .map((s) => s.nextAllowedAt)
            .whereType<DateTime>()
            .where((t) => t.isAfter(DateTime.now()))
            .toList()
          ..sort();
    if (times.isEmpty) return;
    final wait =
        times.first.difference(DateTime.now()) + const Duration(seconds: 1);
    _refresh = Timer(wait, _reloadStatus);
  }

  Future<void> _reloadStatus() async {
    try {
      final s = await client.dose.status(_childId);
      if (mounted) setState(() => _statuses = s);
      _scheduleRefresh();
    } catch (e) {
      _handleError(e);
    }
  }

  void _onStreamError(Object e) => _handleError(e);

  void _onStreamDone() {
    if (!mounted || _shiftEnded) return;
    setState(() {
      _connected = false;
      _statuses = null;
    });
    _retry = Timer(const Duration(seconds: 3), _connect);
  }

  void _handleError(Object e) {
    if (!mounted) return;
    if (e is OneDoseException &&
        (e.code == OneDoseErrorCode.shiftEnded ||
            e.code == OneDoseErrorCode.notAuthorized)) {
      setState(() {
        _shiftEnded = true;
        _shiftMessage ??= e.message;
      });
      _sub?.cancel();
      return;
    }
    setState(() {
      _connected = false;
      _statuses = null;
    });
    _retry?.cancel();
    _retry = Timer(const Duration(seconds: 3), _connect);
  }

  Future<void> _give(MedicineStatus s) async {
    final m = s.medicine;
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Give ${m.name}?'),
        content: Text(
          '${m.doseText} (from the label / doctor).\n'
          'Contains ${m.ingredient}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('I\'m giving it now'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _busy.add(m.id!));
    try {
      final r = await client.dose.logDose(m.id!);
      if (!mounted) return;
      if (r.accepted) {
        _showAccepted(r);
      } else {
        await _showRefused(r, m);
      }
    } catch (e) {
      _showError(e);
    } finally {
      if (mounted) setState(() => _busy.remove(m.id!));
    }
  }

  void _showAccepted(DoseResult r) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Lights.green,
        content: Text(
          '${r.message} Next allowed ${formatTime(r.nextAllowedAt)}.',
        ),
        duration: const Duration(seconds: 8),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () async {
            try {
              await client.dose.undo(r.event.id!);
            } catch (e) {
              _showError(e);
            }
          },
        ),
      ),
    );
  }

  Future<void> _showRefused(DoseResult r, Medicine m) async {
    final override = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        icon: const Icon(Icons.block, color: Lights.red, size: 40),
        title: const Text('Don\'t give it'),
        content: Text(r.message, style: const TextStyle(fontSize: 18)),
        actions: [
          if (_isOwner)
            TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Override (doctor advised)'),
            ),
          FilledButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (override == true && mounted) await _override(m);
  }

  Future<void> _override(Medicine m) async {
    final reason = TextEditingController();
    final go = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Override for ${m.name}'),
        content: TextField(
          controller: reason,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Reason',
            helperText: 'e.g. "Doctor said every 3 hours today"',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Lights.red),
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Log override'),
          ),
        ],
      ),
    );
    if (go != true) return;
    try {
      final r = await client.dose.overrideDose(m.id!, reason.text);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(r.message)));
      }
    } catch (e) {
      _showError(e);
    }
  }

  void _showError(Object e) {
    if (!mounted) return;
    if (e is OneDoseException && e.code == OneDoseErrorCode.shiftEnded) {
      _handleError(e);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Lights.red, content: Text(errorText(e))),
    );
  }

  void _open(Widget screen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final child = widget.circle.child;
    final me = widget.circle.me;
    if (_shiftEnded) {
      return _ShiftEnded(message: _shiftMessage, onOk: widget.onLeft);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(child.name),
        actions: [
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history),
            onPressed: () => _open(HistoryScreen(circle: widget.circle)),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              switch (v) {
                case 'invite':
                  _open(InviteScreen(childId: child.id!));
                case 'members':
                  _open(MembersScreen(circle: widget.circle));
                case 'signout':
                  client.auth.signOutDevice();
              }
            },
            itemBuilder: (_) => [
              if (_isOwner)
                const PopupMenuItem(
                  value: 'invite',
                  child: Text('Invite a sitter or co-parent'),
                ),
              const PopupMenuItem(value: 'members', child: Text('Care circle')),
              const PopupMenuItem(value: 'signout', child: Text('Sign out')),
            ],
          ),
        ],
      ),
      floatingActionButton: _isOwner
          ? FloatingActionButton.extended(
              onPressed: () => _open(MedicineForm(childId: child.id!)),
              icon: const Icon(Icons.add),
              label: const Text('Medicine'),
            )
          : null,
      bottomNavigationBar: const SafetyFooter(),
      body: RefreshIndicator(
        onRefresh: _reloadStatus,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            _Banner(me: me, connected: _connected, demo: _demo),
            for (final a in _alerts)
              _AlertCard(
                alert: a,
                onDismiss: () => setState(() => _alerts.remove(a)),
              ),
            if (_statuses == null && !_connected) ...[
              const SizedBox(height: 32),
              const _CantCheck(),
            ] else if ((_statuses ?? []).isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Text(
                  _isOwner
                      ? 'Add the medicines ${child.name} is taking. Copy the '
                            'dose and limits from the label or the doctor.'
                      : 'No medicines yet. The parent adds them.',
                  textAlign: TextAlign.center,
                ),
              )
            else
              for (final s in _statuses!)
                _MedicineCard(
                  status: s,
                  busy: _busy.contains(s.medicine.id),
                  onGive: () => _give(s),
                  onEdit: _isOwner
                      ? () => _open(
                          MedicineForm(
                            childId: child.id!,
                            medicine: s.medicine,
                          ),
                        )
                      : null,
                ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final CareMember me;
  final bool connected;
  final bool demo;
  const _Banner({
    required this.me,
    required this.connected,
    required this.demo,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    final parts = <String>[
      'You are ${me.displayName}',
      if (me.role == CareRole.sitter && me.shiftEnd != null)
        'shift ${formatTime(me.shiftStart)}–${formatTime(me.shiftEnd)}',
      if (demo) 'Demo timings',
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            connected ? Icons.wifi_tethering : Icons.cloud_off,
            size: 16,
            color: connected ? Lights.green : Lights.unknown,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${connected ? 'Live' : 'Reconnecting…'} · ${parts.join(' · ')}',
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}

class _CantCheck extends StatelessWidget {
  const _CantCheck();

  @override
  Widget build(BuildContext context) => Card(
    color: Lights.unknown.withValues(alpha: 0.12),
    child: const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(Icons.cloud_off, size: 40, color: Lights.unknown),
          SizedBox(height: 8),
          Text(
            'Can\'t check — ask the parent before giving',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

class _AlertCard extends StatelessWidget {
  final CircleEvent alert;
  final VoidCallback onDismiss;
  const _AlertCard({required this.alert, required this.onDismiss});

  @override
  Widget build(BuildContext context) => Card(
    color: Lights.amber.withValues(alpha: 0.15),
    child: ListTile(
      leading: const Icon(Icons.notifications_active, color: Lights.amber),
      title: Text(alert.message ?? 'A dose was missed.'),
      subtitle: Text(formatTime(alert.at)),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onDismiss,
      ),
    ),
  );
}

class _MedicineCard extends StatelessWidget {
  final MedicineStatus status;
  final bool busy;
  final VoidCallback onGive;
  final VoidCallback? onEdit;
  const _MedicineCard({
    required this.status,
    required this.busy,
    required this.onGive,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final m = status.medicine;
    final color = Lights.of(status.light);
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 8)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(m.name, style: text.titleLarge)),
                if (onEdit != null)
                  IconButton(
                    tooltip: 'Edit',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  ),
              ],
            ),
            Text(
              '${m.doseText} · ${m.ingredient} · from label / doctor',
              style: text.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Lights.icon(status.light), color: color),
                const SizedBox(width: 8),
                Text(
                  Lights.label(status.light),
                  style: text.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(status.message),
            const SizedBox(height: 4),
            Text(
              '${status.dosesLast24h} of ${status.maxPer24h} in the last 24 h'
              '${m.fixedTimes.isEmpty ? '' : ' · due ${m.fixedTimes.join(', ')}'}',
              style: text.bodySmall,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: busy ? null : onGive,
                icon: busy
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.medication),
                label: Text('Give ${m.name}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShiftEnded extends StatelessWidget {
  final String? message;
  final VoidCallback onOk;
  const _ShiftEnded({this.message, required this.onOk});

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: const SafetyFooter(),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_clock, size: 64, color: Lights.unknown),
            const SizedBox(height: 16),
            Text(
              message ?? 'Your shift has ended.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Access was closed by the server. Thank you for looking after '
              'them.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: onOk, child: const Text('OK')),
          ],
        ),
      ),
    ),
  );
}
