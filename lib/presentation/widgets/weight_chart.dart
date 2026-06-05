import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/weight_log.dart';

class WeightChart extends StatelessWidget {
  final List<WeightLog> weights;
  final String filter;

  const WeightChart({super.key, required this.weights, required this.filter});

  @override
  Widget build(BuildContext context) {
    final chartLogs = _filteredLogs();
    final spots = chartLogs
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.weight))
        .toList();
    final values = chartLogs.map((log) => log.weight).toList();
    final minWeight = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a < b ? a : b);
    final maxWeight = values.isEmpty
        ? 1.0
        : values.reduce((a, b) => a > b ? a : b);
    final padding = values.length <= 1 ? 1.0 : 0.5;

    return Container(
      height: 230,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: spots.isEmpty
          ? const Center(child: Text('No chart data yet'))
          : LineChart(
              LineChartData(
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: minWeight - padding,
                maxY: maxWeight + padding,

                // Remove all grid lines
                gridData: const FlGridData(show: false),

                // Remove chart border
                borderData: FlBorderData(show: false),

                // Clean labels
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      interval: _weightInterval(minWeight, maxWeight),
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        );
                      },
                    ),
                  ),

                  // Only show dates at bottom
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: spots.length > 6 ? 2 : 1,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();

                        if (index < 0 ||
                            index >= chartLogs.length ||
                            value != index.toDouble()) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _formatAxisDate(chartLogs[index].logDate),
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                lineTouchData: LineTouchData(enabled: true),

                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 4,
                    color: Colors.blue,

                    // Remove point circles
                    dotData: const FlDotData(show: false),

                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withValues(alpha: 0.15),
                    ),

                    spots: spots,
                  ),
                ],
              ),
            ),
    );
  }

  List<WeightLog> _filteredLogs() {
    final now = DateTime.now();
    final cutoff = switch (filter) {
      'daily' => now.subtract(const Duration(days: 7)),
      'monthly' => DateTime(now.year, now.month - 5, 1),
      _ => now.subtract(const Duration(days: 30)),
    };

    final filtered =
        weights
            .where(
              (log) =>
                  log.logDate.isAfter(cutoff) ||
                  _isSameDay(log.logDate, cutoff),
            )
            .toList()
          ..sort((a, b) => a.logDate.compareTo(b.logDate));

    return filtered;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  double _weightInterval(double minWeight, double maxWeight) {
    final range = maxWeight - minWeight;

    if (range <= 3) {
      return 1;
    }

    return (range / 4).ceilToDouble();
  }

  String _formatAxisDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (filter == 'monthly') {
      return months[date.month - 1];
    }

    return '${months[date.month - 1]} ${date.day}';
  }
}
