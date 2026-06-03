import '../database/database_helper.dart';
import '../models/weight_log.dart';

class WeightRepository {
  final DatabaseHelper _dbHelper =
      DatabaseHelper.instance;

  Future<int> addWeight(
    WeightLog weightLog,
  ) async {
    final db = await _dbHelper.database;

    return await db.insert(
      'weight_logs',
      weightLog.toMap(),
    );
  }

  Future<List<WeightLog>> getAllWeights() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'weight_logs',
      orderBy: 'log_date DESC',
    );

    return result
        .map(
          (e) => WeightLog.fromMap(e),
        )
        .toList();
  }

  Future<int> updateWeight(
    WeightLog weightLog,
  ) async {
    final db = await _dbHelper.database;

    return await db.update(
      'weight_logs',
      weightLog.toMap(),
      where: 'id = ?',
      whereArgs: [weightLog.id],
    );
  }

  Future<int> deleteWeight(
    int id,
  ) async {
    final db = await _dbHelper.database;

    return await db.delete(
      'weight_logs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllWeights() async {
    final db = await _dbHelper.database;

    await db.delete(
      'weight_logs',
    );
  }
}