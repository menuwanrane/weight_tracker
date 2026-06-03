import 'package:flutter/material.dart';

import '../../widgets/history_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedSort = 'Newest';

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search records',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Text(
                    'Sort:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 12),

                  DropdownButton<String>(
                    value: selectedSort,
                    items: const [
                      DropdownMenuItem(
                        value: 'Newest',
                        child: Text('Newest'),
                      ),
                      DropdownMenuItem(
                        value: 'Oldest',
                        child: Text('Oldest'),
                      ),
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
                child: ListView(
                  children: [
                    HistoryTile(
                      weight: '82.5 kg',
                      date: '03 Jun 2026',
                      onEdit: () {},
                      onDelete: () {},
                    ),

                    HistoryTile(
                      weight: '82.8 kg',
                      date: '02 Jun 2026',
                      onEdit: () {},
                      onDelete: () {},
                    ),

                    HistoryTile(
                      weight: '83.0 kg',
                      date: '01 Jun 2026',
                      onEdit: () {},
                      onDelete: () {},
                    ),

                    HistoryTile(
                      weight: '83.2 kg',
                      date: '31 May 2026',
                      onEdit: () {},
                      onDelete: () {},
                    ),

                    HistoryTile(
                      weight: '83.4 kg',
                      date: '30 May 2026',
                      onEdit: () {},
                      onDelete: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}