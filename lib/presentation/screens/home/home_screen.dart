import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/weight_provider.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/weight_card.dart';
import '../../widgets/weight_chart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends ConsumerState<HomeScreen> {
  String selectedFilter = 'weekly';

  @override
  Widget build(BuildContext context) {
    final weights = ref.watch(weightProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: weights.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),

        data: (data) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weight Tracker',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const WeightCard(),

                  const SizedBox(height: 16),

                  _buildAddWeightButton(),

                  const SizedBox(height: 24),

                  Text(
                    'Weight Progress',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),

                  const SizedBox(height: 16),

                  FilterChips(
                    selected: selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  const WeightChart(),

                  const SizedBox(height: 24),

                  Text(
                    'Recent Records (${data.length})',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),

                  const SizedBox(height: 12),

                  if (data.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          'No weight records yet',
                        ),
                      ),
                    )
                  else
                    ...data.take(5).map(
                      (weight) => _recordTile(
                        '${weight.weight} kg',
                        weight.logDate
                            .toString()
                            .split(' ')[0],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddWeightButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3B82F6),
              Color(0xFF2563EB),
            ],
          ),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add Weight',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _recordTile(
    String weight,
    String date,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(
          Icons.monitor_weight,
        ),
        title: Text(weight),
        subtitle: Text(date),
      ),
    );
  }
}