import 'package:workout_app/models/training_record_model.dart';

import 'equip_records_model.dart';

class EquipModel {
  int id;
  String name;
  String note;
  String ?image;
  List<double> ?weights;
  List<EquipRecordsModel> ?records;

  EquipModel({
    required this.id,
    required this.name,
    required this.note,
    this.weights,
    this.records,
    this.image,
  });

factory EquipModel.fromJson(Map<String, dynamic> json) {
    return EquipModel(
      id: json['id'],
      name: json['name'],
      note: json['note'] ?? '',
      records: json['records'] != null ? List<EquipRecordsModel>.from(
        json['records'].map((record) => EquipRecordsModel.fromJson(record)),
      ) : null,
      weights: json['weights'] != null ? List<double>.from(
        json['weights'].map((weight) => weight.toDouble()),
      ) : null,
      image: json['image'] ?? null,
    );
  }
}