import 'package:workout_app/models/training_model.dart';

import 'equip_model.dart';

class MaxVolumeRecordModel {
  final int id;
  final double maxWeight;
  final int maxWeightReps;
  final double dayVolume;

  MaxVolumeRecordModel({
    required this.id,
    required this.maxWeight,
    required this.maxWeightReps,
    required this.dayVolume,
  });

  factory MaxVolumeRecordModel.fromJson(Map<String, dynamic> json) {
    return MaxVolumeRecordModel(
      id: json['id'],
      maxWeight: json['maxWeight'].toDouble(),
      maxWeightReps: json['maxWeightReps'],
      dayVolume: json['dayVolume'].toDouble(),
    );
  }
}
