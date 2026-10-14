import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:flutter/services.dart';
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/page_header.dart';

/// Owner only: a one-time link for a sitter's shift, or a co-parent.
class InviteView extends StatefulWidget {
  final int childId;
  const InviteView({super.key, required this.childId});

  @override
  State<InviteView> createState() => _InviteViewState();
}

class _InviteViewState extends State<InviteView> {
  final _name = TextEditingController(text: 'Grandpa');
  CareRole _role = CareRole.sitter;
  late DateTime _start = DateTime.now();
  late DateTime _end = DateTime.now().add(const Duration(hours: 5));
  InviteCreated? _created;
  String? _error;

  Future<void> _pick(bool start) async {
    final base = start ? _start : _end;
    final date = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (time == null) return;
    final v = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => start ? _start = v : _end = v);
  }

  Future<void> _create() async {
    try {
      final c = await client.invite.create(
        childId: widget.childId,
        displayName: _name.text,
        role: _role,
        shiftStart: _role == CareRole.sitter ? _start.toUtc() : null,
        shiftEnd: _role == CareRole.sitter ? _end.toUtc() : null,
      );
      setState(() {
        _created = c;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = errorText(e));
    }
  }

  String _link(String token) {
    final base = kIsWeb ? Uri.base.origin : 'https://onedose.app';
    return '$base/?invite=$token';
  }

  Widget _shiftBox(String label, DateTime value, VoidCallback onTap) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Ink.line),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontSize: 13, color: Ink.muted),
                    ),
                    Text(
                      formatDateTime(value),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Ink.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit_calendar, size: 18, color: Ink.muted),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final created = _created;
    return ListView(
      padding: AppShell.pagePadding(context),
      children: [
        const PageHeader(
          title: 'Invite',
          subtitle: 'A one-time code for a sitter\'s shift, or a co-parent.',
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<CareRole>(
                    segments: const [
                      ButtonSegment(
                        value: CareRole.sitter,
                        label: Text('Sitter'),
                      ),
                      ButtonSegment(
                        value: CareRole.coparent,
                        label: Text('Co-parent'),
                      ),
                    ],
                    selected: {_role},
                    onSelectionChanged: (s) => setState(() => _role = s.first),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Their name in the circle',
                  ),
                ),
                if (_role == CareRole.sitter) ...[
                  const SizedBox(height: 16),
                  _shiftBox('Shift starts', _start, () => _pick(true)),
                  const SizedBox(height: 12),
                  _shiftBox('Shift ends', _end, () => _pick(false)),
                  const SizedBox(height: 12),
                  const Text(
                    'They see the current status and what happens during the '
                    'shift. Access is closed by the server when it ends.',
                    style: TextStyle(fontSize: 14, color: Ink.muted),
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _create,
                  child: const Text('Create invite'),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: const TextStyle(fontSize: 14, color: Lights.red),
                  ),
                ],
                if (created != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Ink.soft,
                      border: Border.all(color: Ink.line),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Send them this code or link',
                          style: TextStyle(fontSize: 13, color: Ink.muted),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          created.token,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: Ink.ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          _link(created.token),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Ink.muted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(Icons.copy, size: 18),
                              label: const Text('Copy link'),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: _link(created.token)),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Link copied'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Valid once, for 2 days.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Ink.faint,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
