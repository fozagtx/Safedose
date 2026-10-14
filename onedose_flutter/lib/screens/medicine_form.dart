import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

import '../client.dart';
import '../theme.dart';

/// Owner only. Every value is copied from the label or the doctor; the app
/// never suggests one.
class MedicineForm extends StatefulWidget {
  final int childId;
  final Medicine? medicine;
  const MedicineForm({super.key, required this.childId, this.medicine});

  @override
  State<MedicineForm> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  late final _name = TextEditingController(text: widget.medicine?.name);
  late final _ingredient = TextEditingController(
    text: widget.medicine?.ingredient,
  );
  late final _dose = TextEditingController(text: widget.medicine?.doseText);
  late final _hours = TextEditingController(
    text: widget.medicine == null ? '' : _num(widget.medicine!.minHoursBetween),
  );
  late final _max = TextEditingController(
    text: widget.medicine?.maxPer24h.toString(),
  );
  late final _times = TextEditingController(
    text: widget.medicine?.fixedTimes.join(', '),
  );
  bool _busy = false;
  String? _error;

  static String _num(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  Future<void> _save() async {
    final hours = double.tryParse(_hours.text.trim());
    final max = int.tryParse(_max.text.trim());
    if (hours == null || max == null) {
      setState(() => _error = 'Enter the hours and the maximum as numbers.');
      return;
    }
    final m = Medicine(
      id: widget.medicine?.id,
      childId: widget.childId,
      name: _name.text,
      ingredient: _ingredient.text,
      doseText: _dose.text,
      minHoursBetween: hours,
      maxPer24h: max,
      fixedTimes: _times.text
          .split(RegExp(r'[,\s]+'))
          .where((t) => t.isNotEmpty)
          .toList(),
    );
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (m.id == null) {
        await client.medicine.add(m);
      } else {
        await client.medicine.update(m);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = errorText(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _archive() async {
    try {
      await client.medicine.archive(widget.medicine!.id!);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = errorText(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine == null ? 'Add medicine' : 'Edit medicine'),
        actions: [
          if (widget.medicine != null)
            IconButton(
              tooltip: 'Remove from card',
              icon: const Icon(Icons.delete_outline),
              onPressed: _archive,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Copy every value from the label or from the doctor. '
                'OneDose never suggests a dose.',
              ),
            ),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name, e.g. Calpol'),
          ),
          TextField(
            controller: _ingredient,
            decoration: const InputDecoration(
              labelText: 'Active ingredient, e.g. paracetamol',
              helperText:
                  'Medicines with the same ingredient share one lockout.',
            ),
          ),
          TextField(
            controller: _dose,
            decoration: const InputDecoration(labelText: 'Dose, e.g. 5 ml'),
          ),
          TextField(
            controller: _hours,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Minimum hours between doses',
            ),
          ),
          TextField(
            controller: _max,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Maximum doses in 24 hours',
            ),
          ),
          TextField(
            controller: _times,
            decoration: const InputDecoration(
              labelText: 'Fixed times (optional)',
              helperText:
                  'e.g. 08:00, 20:00 for an antibiotic. Missed '
                  'doses are escalated.',
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Lights.red)),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _busy ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
