import 'package:workout_app/models/equip_summary_model.dart';
import 'package:workout_app/models/training_model.dart';

class EquipSummaryListModel {
  final int total;
  final List<EquipSummaryModel> equipSummaries;

  EquipSummaryListModel({
    required this.total,
    required this.equipSummaries,
  });

  factory EquipSummaryListModel.fromJson(Map<String, dynamic> json) {
    print("jsonData");
    print(json['data']);

    return EquipSummaryListModel(
      total: json['total'],
      equipSummaries: List<EquipSummaryModel>.from(
        json['data'].map((equipSummary) => EquipSummaryModel.fromJson(equipSummary)),
      ),
    );
  }
}
