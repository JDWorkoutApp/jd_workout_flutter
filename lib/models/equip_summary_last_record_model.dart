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
      reps: double.parse(json['reps'].toString()),
      sets: double.parse(json['sets'].toString()),
      volume: double.parse(json['volume'].toString()),
      weight: double.parse(json['weight'].toString()),
    );
  }
}
