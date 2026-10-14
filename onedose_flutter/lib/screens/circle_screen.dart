import 'dart:async';

import 'package:flutter/material.dart' hide Ink;
import 'package:onedose_client/onedose_client.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/brand_mark.dart';
import '../widgets/page_header.dart';
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

  int _section = 0;

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
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Lights.green, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${r.message} Next allowed ${formatTime(r.nextAllowedAt)}.',
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 8),
        action: SnackBarAction(
          label: 'Undo',
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

  /// 'Live · You are Mum · shift 6–9pm · Demo timings' in one grey pill.
  Widget _statusPill() {
    final me = widget.circle.me;
    final parts = <String>[
      'You are ${me.displayName}',
      if (me.role == CareRole.sitter && me.shiftEnd != null)
        'shift ${formatTime(me.shiftStart)}–${formatTime(me.shiftEnd)}',
      if (_demo) 'Demo timings',
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Ink.field,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _connected ? Lights.green : Lights.unknown,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '${_connected ? 'Live' : 'Reconnecting…'} · ${parts.join(' · ')}',
              style: const TextStyle(fontSize: 13, color: Ink.muted),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _todayBody() {
    final child = widget.circle.child;
    final wide = AppShell.isWide(context);
    return RefreshIndicator(
      onRefresh: _reloadStatus,
      child: ListView(
        padding: AppShell.pagePadding(context),
        children: [
          PageHeader(
            title: child.name,
            subtitle: _isOwner
                ? 'Every dose, once. Tap Give and the server checks '
                      'before anyone can give it twice.'
                : 'Tap Give and the server checks before anyone can '
                      'give it twice.',
            meta: wide ? null : _statusPill(),
          ),
          for (final a in _alerts) ...[
            _AlertCard(
              alert: a,
              onDismiss: () => setState(() => _alerts.remove(a)),
            ),
            const SizedBox(height: 12),
          ],
          if (_statuses == null && !_connected) ...[
            const SizedBox(height: 32),
            const _CantCheck(),
          ] else if ((_statuses ?? []).isEmpty)
            _EmptyToday(
              isOwner: _isOwner,
              childName: child.name,
              onAdd: () => _open(MedicineForm(childId: child.id!)),
            )
          else
            LayoutBuilder(
              builder: (context, c) {
                final columns = c.maxWidth >= 1000
                    ? 3
                    : c.maxWidth >= 640
                    ? 2
                    : 1;
                const spacing = 20.0;
                final w = (c.maxWidth - spacing * (columns - 1)) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: 24,
                  children: [
                    for (final s in _statuses!)
                      SizedBox(
                        width: w,
                        child: _MedicineCard(
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
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.circle.child;
    if (_shiftEnded) {
      return _ShiftEnded(message: _shiftMessage, onOk: widget.onLeft);
    }

    final items = <ShellNavItem>[
      const ShellNavItem(Icons.medication_outlined, 'Today'),
      const ShellNavItem(Icons.history, 'History'),
      const ShellNavItem(Icons.group_outlined, 'Care circle'),
      if (_isOwner)
        const ShellNavItem(Icons.person_add_alt_1_outlined, 'Invite'),
    ];

    return AppShell(
      items: items,
      selected: _section,
      onSelect: (i) => setState(() => _section = i),
      onSignOut: () => client.auth.signOutDevice(),
      status: _statusPill(),
      topActions: [
        if (_isOwner)
          OutlinedButton(
            onPressed: () => setState(() => _section = 3),
            child: const Text('Invite'),
          ),
      ],
      primaryAction: _isOwner
          ? AppShell.isWide(context)
                ? FilledButton.icon(
                    onPressed: () => _open(MedicineForm(childId: child.id!)),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add medicine'),
                  )
                : IconButton.filled(
                    tooltip: 'Add medicine',
                    onPressed: () => _open(MedicineForm(childId: child.id!)),
                    style: IconButton.styleFrom(
                      backgroundColor: Ink.ink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                  )
          : null,
      body: switch (_section) {
        1 => HistoryView(circle: widget.circle),
        2 => MembersView(circle: widget.circle),
        3 when _isOwner => InviteView(childId: child.id!),
        _ => _todayBody(),
      },
    );
  }
}

class _CantCheck extends StatelessWidget {
  const _CantCheck();

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Ink.soft,
      border: Border.all(color: Ink.line),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(24),
    child: const Column(
      children: [
        Icon(Icons.cloud_off, size: 32, color: Lights.unknown),
        SizedBox(height: 8),
        Text(
          'Can\'t check — ask the parent before giving',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class _EmptyToday extends StatelessWidget {
  final bool isOwner;
  final String childName;
  final VoidCallback onAdd;
  const _EmptyToday({
    required this.isOwner,
    required this.childName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Ink.line),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text('No medicines yet', style: text.titleLarge),
          const SizedBox(height: 8),
          Text(
            isOwner
                ? 'Add the medicines $childName is taking. Copy the '
                      'dose and limits from the label or the doctor.'
                : 'The parent adds them.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Ink.muted),
          ),
          if (isOwner) ...[
            const SizedBox(height: 20),
            FilledButton(onPressed: onAdd, child: const Text('Add medicine')),
          ],
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final CircleEvent alert;
  final VoidCallback onDismiss;
  const _AlertCard({required this.alert, required this.onDismiss});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Lights.amber.withValues(alpha: 0.08),
      border: Border.all(color: Lights.amber.withValues(alpha: 0.25)),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        const Icon(
          Icons.notifications_active,
          color: Lights.amber,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alert.message ?? 'A dose was missed.',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Ink.ink,
                ),
              ),
              Text(
                formatTime(alert.at),
                style: const TextStyle(fontSize: 13, color: Ink.muted),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 18),
          onPressed: onDismiss,
        ),
      ],
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
    final buttonIcon = busy
        ? const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.medication, size: 18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 150),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.07),
            border: Border.all(color: Ink.line),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Ink.line),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Lights.icon(status.light),
                          size: 14,
                          color: color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          Lights.label(status.light),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (onEdit != null)
                    IconButton(
                      tooltip: 'Edit',
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      onPressed: onEdit,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                status.message,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Ink.ink,
                  letterSpacing: -0.4,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${status.dosesLast24h} of ${status.maxPer24h} in the last 24 h'
                '${m.fixedTimes.isEmpty ? '' : ' · due ${m.fixedTimes.join(', ')}'}',
                style: const TextStyle(fontSize: 13, color: Ink.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.medication,
                size: 13,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Ink.ink,
                    ),
                  ),
                  Text(
                    '${m.doseText} · ${m.ingredient} · from label / doctor',
                    style: const TextStyle(fontSize: 14, color: Ink.faint),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: status.light == StatusLight.green
              ? FilledButton.icon(
                  onPressed: busy ? null : onGive,
                  icon: buttonIcon,
                  label: Text('Give ${m.name}'),
                )
              : OutlinedButton.icon(
                  onPressed: busy ? null : onGive,
                  icon: buttonIcon,
                  label: Text('Give ${m.name}'),
                ),
        ),
      ],
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BrandMark(),
              const SizedBox(height: 32),
              const Icon(Icons.lock_clock, size: 48, color: Lights.unknown),
              const SizedBox(height: 16),
              Text(
                message ?? 'Your shift has ended.',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Access was closed by the server. Thank you for looking '
                'after them.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Ink.muted),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: onOk, child: const Text('OK')),
            ],
          ),
        ),
      ),
    ),
  );
}
