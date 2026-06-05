import 'package:flutter/material.dart';

import '../utils/weight_units.dart';

class WeightCard extends StatelessWidget {
  final double? weight;
  final DateTime? logDate;
  final String unit;

  const WeightCard({
    super.key,
    required this.weight,
    required this.logDate,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Weight',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  weight == null
                      ? '-- ${unitSuffix(unit)}'
                      : formatWeight(weight!, unit),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  logDate == null
                      ? 'No records yet'
                      : 'Last updated ${_formatDate(logDate!)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.monitor_weight, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);

    if (normalizedDate == normalizedToday) {
      return 'today';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
