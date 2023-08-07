class EquipSummaryLastRecordModel {
  final double reps;
  final double sets;
  final double volume;
  final double weight;

  EquipSummaryLastRecordModel({
    required this.reps,
    required this.sets,
    required this.volume,
    required this.weight,
  });

  factory EquipSummaryLastRecordModel.fromJson(Map<String, dynamic> json) {
    return EquipSummaryLastRecordModel(
      reps: json['reps'],
      sets: json['sets'],
      volume: json['volume'],
      weight: json['weight'],
    );
  }
}
