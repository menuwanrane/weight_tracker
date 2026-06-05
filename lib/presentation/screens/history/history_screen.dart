import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/weight_log.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weight_provider.dart';
import '../../utils/weight_units.dart';
import '../edit_weight.dart/edit_weight_screen.dart';
import '../../widgets/history_tile.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedSort = 'Newest';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weights = ref.watch(weightProvider);
    final settings = ref.watch(settingsProvider);
    final unit = settings.valueOrNull?.weightUnit ?? 'KG';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search records',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Text(
                    'Sort:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(width: 12),

                  DropdownButton<String>(
                    value: selectedSort,
                    items: const [
                      DropdownMenuItem(value: 'Newest', child: Text('Newest')),
                      DropdownMenuItem(value: 'Oldest', child: Text('Oldest')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: weights.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  data: (data) {
                    final visibleLogs = _visibleLogs(data);

                    if (visibleLogs.isEmpty) {
                      return const Center(
                        child: Text('No weight records found'),
                      );
                    }

                    return ListView.builder(
                      itemCount: visibleLogs.length,
                      itemBuilder: (context, index) {
                        final log = visibleLogs[index];

                        return HistoryTile(
                          weight: formatWeight(log.weight, unit),
                          date: _formatDate(log.logDate),
                          onEdit: () => _openEdit(log),
                          onDelete: () => _delete(log),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<WeightLog> _visibleLogs(List<WeightLog> data) {
    final query = searchController.text.trim().toLowerCase();

    final filtered = data.where((log) {
      if (query.isEmpty) {
        return true;
      }

      return log.weight.toString().contains(query) ||
          _formatDate(log.logDate).toLowerCase().contains(query);
    }).toList();

    filtered.sort((a, b) {
      final comparison = a.logDate.compareTo(b.logDate);

      return selectedSort == 'Newest' ? -comparison : comparison;
    });

    return filtered;
  }

  void _openEdit(WeightLog log) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => EditWeightScreen(weightLog: log)));
  }

  Future<void> _delete(WeightLog log) async {
    final id = log.id;

    if (id == null) {
      return;
    }

    await ref.read(weightProvider.notifier).deleteWeight(id);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
