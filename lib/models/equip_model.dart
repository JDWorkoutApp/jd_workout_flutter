import 'package:workout_app/models/training_record_model.dart';

class EquipModel {
  int id;
  String name;
  String note;
  List<TrainingRecordModel> ?records;
  List<double> ?weights;

  EquipModel({
    required this.id,
    required this.name,
    required this.note,
    this.records,
    this.weights,
  });

factory EquipModel.fromJson(Map<String, dynamic> json) {
    return EquipModel(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      records: List<TrainingRecordModel>.from(
        json['records'].map((record) => TrainingRecordModel.fromJson(record)),
      ),
    );
  }
}