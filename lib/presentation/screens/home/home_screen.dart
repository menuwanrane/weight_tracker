import 'package:flutter/material.dart';

import '../../widgets/filter_chips.dart';
import '../../widgets/weight_card.dart';
import '../../widgets/weight_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                style: Theme.of(context).textTheme.titleLarge,
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
                'Recent Records',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 12),

              _recordTile('82.5 kg', '03 Jun 2026'),
              _recordTile('82.8 kg', '02 Jun 2026'),
              _recordTile('83.0 kg', '01 Jun 2026'),
            ],
          ),
        ),
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
              fontWeight: FontWeight.w600,
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
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.monitor_weight,
          color: Colors.blue,
        ),
      ),
      title: Text(weight),
      subtitle: Text(date),
      trailing: const Icon(
        Icons.edit_outlined,
      ),
    ),
  );
}
}