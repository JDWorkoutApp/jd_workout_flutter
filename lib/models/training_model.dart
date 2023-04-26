import 'package:workout_app/models/equip_model.dart';

class TrainingModel {
  final String date;
  final String start;
  final String end;
  final List<EquipModel> equipments;

  TrainingModel({
    required this.date,
    required this.start,
    required this.end,
    required this.equipments,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      date: json['date'],
      start: json['start'],
      end: json['end'],
      equipments: List<EquipModel>.from(
        json['equips'].map((equipment) => EquipModel.fromJson(equipment)),
      ),
    );
  }
}