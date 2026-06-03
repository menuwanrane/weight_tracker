import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          minY: 81,
          maxY: 84,

          // Remove all grid lines
          gridData: const FlGridData(
            show: false,
          ),

          // Remove chart border
          borderData: FlBorderData(
            show: false,
          ),

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
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color,
                    ),
                  );
                },
              ),
            ),

            // Only show dates at bottom
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  const labels = [
                    'May 28',
                    'May 30',
                    'Jun 1',
                    'Jun 3',
                  ];

                  if (value.toInt() < 0 ||
                      value.toInt() >= labels.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[value.toInt()],
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          lineTouchData: LineTouchData(
            enabled: true,
          ),

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 4,
              color: Colors.blue,

              // Remove point circles
              dotData: const FlDotData(
                show: false,
              ),

              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.15),
              ),

              // KEEPING YOUR ORIGINAL VALUES
              spots: const [
                FlSpot(0, 82.2),
                FlSpot(1, 82.8),
                FlSpot(2, 82.5),
                FlSpot(3, 83.2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}