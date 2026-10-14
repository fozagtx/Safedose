import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';

/// Owner only: a one-time link for a sitter's shift, or a co-parent.
class InviteScreen extends StatefulWidget {
  final int childId;
  const InviteScreen({super.key, required this.childId});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
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

  @override
  Widget build(BuildContext context) {
    final created = _created;
    return Scaffold(
      appBar: AppBar(title: const Text('Invite')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<CareRole>(
            segments: const [
              ButtonSegment(value: CareRole.sitter, label: Text('Sitter')),
              ButtonSegment(value: CareRole.coparent, label: Text('Co-parent')),
            ],
            selected: {_role},
            onSelectionChanged: (s) => setState(() => _role = s.first),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Their name in the circle',
            ),
          ),
          if (_role == CareRole.sitter) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Shift starts'),
              subtitle: Text(formatDateTime(_start)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () => _pick(true),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Shift ends'),
              subtitle: Text(formatDateTime(_end)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () => _pick(false),
            ),
            const Text(
              'They see the current status and what happens during the '
              'shift. Access is closed by the server when it ends.',
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(onPressed: _create, child: const Text('Create invite')),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Lights.red)),
          ],
          if (created != null) ...[
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Send them this code or link:'),
                    const SizedBox(height: 8),
                    SelectableText(
                      created.token,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SelectableText(_link(created.token)),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy link'),
                      onPressed: () => Clipboard.setData(
                        ClipboardData(text: _link(created.token)),
                      ),
                    ),
                    const Text('Valid once, for 2 days.'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
