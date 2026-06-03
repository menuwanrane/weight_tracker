import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const FilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
          label: const Text('Daily'),
          selected: selected == 'daily',
          onSelected: (_) => onChanged('daily'),
        ),
        ChoiceChip(
          label: const Text('Weekly'),
          selected: selected == 'weekly',
          onSelected: (_) => onChanged('weekly'),
        ),
        ChoiceChip(
          label: const Text('Monthly'),
          selected: selected == 'monthly',
          onSelected: (_) => onChanged('monthly'),
        ),
      ],
    );
  }
}