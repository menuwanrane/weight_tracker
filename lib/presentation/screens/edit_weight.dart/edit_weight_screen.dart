import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/weight_log.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weight_provider.dart';
import '../../utils/weight_units.dart';

class EditWeightScreen extends ConsumerStatefulWidget {
  final WeightLog weightLog;

  const EditWeightScreen({super.key, required this.weightLog});

  @override
  ConsumerState<EditWeightScreen> createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends ConsumerState<EditWeightScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _weightController;
  late DateTime _selectedDate;
  bool _saving = false;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    final unit = ref.read(settingsProvider).valueOrNull?.weightUnit ?? 'KG';
    _weightController = TextEditingController(
      text: displayWeight(widget.weightLog.weight, unit).toStringAsFixed(1),
    );
    _selectedDate = widget.weightLog.logDate;
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unit = ref.watch(settingsProvider).valueOrNull?.weightUnit ?? 'KG';

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Weight')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Weight',
                  suffixText: unitSuffix(unit),
                  prefixIcon: const Icon(Icons.monitor_weight),
                ),
                validator: (value) {
                  final parsed = double.tryParse(value?.trim() ?? '');

                  if (parsed == null || parsed <= 0) {
                    return 'Enter a valid weight';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date'),
                subtitle: Text(_formatDate(_selectedDate)),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickDate,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saving || _deleting ? null : _update,
                icon: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: const Text('Update'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _saving || _deleting ? null : _delete,
                icon: _deleting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline),
                label: const Text('Delete'),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDate = picked;
    });
  }

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _saving = true;
    });

    final unit = ref.read(settingsProvider).valueOrNull?.weightUnit ?? 'KG';

    await ref
        .read(weightProvider.notifier)
        .updateWeight(
          WeightLog(
            id: widget.weightLog.id,
            weight: kilogramsFromInput(
              double.parse(_weightController.text.trim()),
              unit,
            ),
            logDate: DateTime(
              _selectedDate.year,
              _selectedDate.month,
              _selectedDate.day,
              widget.weightLog.logDate.hour,
              widget.weightLog.logDate.minute,
              widget.weightLog.logDate.second,
            ),
            createdAt: widget.weightLog.createdAt,
          ),
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final id = widget.weightLog.id;

    if (id == null) {
      return;
    }

    setState(() {
      _deleting = true;
    });

    await ref.read(weightProvider.notifier).deleteWeight(id);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
