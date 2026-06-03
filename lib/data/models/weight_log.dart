class WeightLog {
  final int? id;
  final double weight;
  final DateTime logDate;
  final DateTime createdAt;

  const WeightLog({
    this.id,
    required this.weight,
    required this.logDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight_value': weight,
      'log_date': logDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WeightLog.fromMap(
    Map<String, dynamic> map,
  ) {
    return WeightLog(
      id: map['id'],
      weight: map['weight_value'],
      logDate: DateTime.parse(
        map['log_date'],
      ),
      createdAt: DateTime.parse(
        map['created_at'],
      ),
    );
  }
}