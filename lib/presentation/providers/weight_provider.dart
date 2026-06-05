import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/weight_log.dart';
import '../../data/respositories/weight_respository.dart'; 

final weightRepositoryProvider =
    Provider<WeightRepository>(
  (ref) => WeightRepository(),
);

final weightProvider =
    StateNotifierProvider<
        WeightNotifier,
        AsyncValue<List<WeightLog>>>(
  (ref) {
    return WeightNotifier(
      ref.read(weightRepositoryProvider),
    );
  },
);

class WeightNotifier
    extends StateNotifier<
        AsyncValue<List<WeightLog>>> {
  final WeightRepository repository;

  WeightNotifier(this.repository)
      : super(const AsyncLoading()) {
    loadWeights();
  }

  Future<void> loadWeights() async {
    try {
      final weights =
          await repository.getAllWeights();

      state = AsyncData(weights);
    } catch (e) {
      state = AsyncError(
        e,
        StackTrace.current,
      );
    }
  }

  Future<void> addWeight(
    WeightLog weight,
  ) async {
    await repository.addWeight(weight);

    await loadWeights();
  }

  Future<void> deleteWeight(
    int id,
  ) async {
    await repository.deleteWeight(id);

    await loadWeights();
  }

  Future<void> updateWeight(
    WeightLog weight,
  ) async {
    await repository.updateWeight(weight);

    await loadWeights();
  }
}