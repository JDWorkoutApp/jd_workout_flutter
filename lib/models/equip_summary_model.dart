import 'package:workout_app/models/training_summary_model.dart';

import 'equip_model.dart';
import 'equip_summary_last_record_model.dart';
import 'max_volume_record_model.dart';
import 'max_weight_record_model.dart';

class EquipSummaryModel {
  final EquipModel equip;
  final MaxWeightRecordModel ?maxWeightRecord;
  final MaxVolumeRecordModel ?maxVolumeRecord;
  final List<EquipSummaryLastRecordModel> ?lastRecords;
  final DateTime ?lastUsed;

  EquipSummaryModel({
    required this.equip,
    this.maxWeightRecord,
    this.maxVolumeRecord,
    this.lastRecords,
    this.lastUsed,
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
      lastRecords: json['lastRecords'] != null
        ? List<EquipSummaryLastRecordModel>.from(
          json['lastRecords'].map((record) => EquipSummaryLastRecordModel.fromJson(record)),
        )
        : null,
      lastUsed: json['lastUsed'] != null
        ? DateTime.parse(json['lastUsed'])
        : null,
    );
  }
}
