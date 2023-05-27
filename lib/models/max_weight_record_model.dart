import 'package:workout_app/models/training_summary_model.dart';

import 'equip_model.dart';

class MaxWeightRecordModel {
  final int id;
  final double weight;
  final int reps;
  final double dayVolume;

  MaxWeightRecordModel({
    required this.id,
    required this.weight,
    required this.reps,
    required this.dayVolume,
  });

  factory MaxWeightRecordModel.fromJson(Map<String, dynamic> json) {
    return MaxWeightRecordModel(
      id: json['id'],
      weight: json['weight'].toDouble(),
      reps: json['reps'],
      dayVolume: json['dayVolume'].toDouble(),
    );
  }
}
