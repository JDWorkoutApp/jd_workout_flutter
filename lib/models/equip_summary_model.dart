import 'package:workout_app/models/training_model.dart';

import 'equip_model.dart';
import 'max_volume_record_model.dart';
import 'max_weight_record_model.dart';

class EquipSummaryModel {
  final EquipModel equip;
  final MaxWeightRecordModel ?maxWeightRecord;
  final MaxVolumeRecordModel ?maxVolumeRecord;

  EquipSummaryModel({
    required this.equip,
    this.maxWeightRecord,
    this.maxVolumeRecord,
  });

  factory EquipSummaryModel.fromJson(Map<String, dynamic> json) {
    return EquipSummaryModel(
      equip: EquipModel.fromJson(json['equip']),
      maxWeightRecord: json['maxWeightRecord'] != null
        ? MaxWeightRecordModel.fromJson(json['maxWeightRecord'])
        : null,
      maxVolumeRecord: json['maxVolumeRecord'] != null
        ? MaxVolumeRecordModel.fromJson(json['maxVolumeRecord'])
        : null,
    );
  }
}
