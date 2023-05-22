import 'package:workout_app/models/training_record_model.dart';

import 'equip_records_model.dart';

class EquipModel {
  int id;
  String name;
  String note;
  List<double> ?weights;
  List<EquipRecordsModel> ?records;

  EquipModel({
    required this.id,
    required this.name,
    required this.note,
    this.weights,
    this.records,
  });

factory EquipModel.fromJson(Map<String, dynamic> json) {
    return EquipModel(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      records: json['records'] != null ? List<EquipRecordsModel>.from(
        json['records'].map((record) => EquipRecordsModel.fromJson(record)),
      ) : null,
    );
  }
}