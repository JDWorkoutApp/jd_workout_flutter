import 'package:workout_app/models/training_record_model.dart';

class TrainingRecordListModel {
  final int total;
  final List<TrainingRecordModel> records;

  TrainingRecordListModel({
    required this.total,
    required this.records,
  });

  factory TrainingRecordListModel.fromJson(Map<String, dynamic> json) {
    return TrainingRecordListModel(
      total: json['total'],
      records: List<TrainingRecordModel>.from(
        json['data'].map((record) => TrainingRecordModel.fromJson(record)),
      ),
    );
  }
}
