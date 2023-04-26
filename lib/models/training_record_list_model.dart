import 'package:workout_app/models/training_model.dart';

class TrainingRecordListModel {
  final int total;
  final List<TrainingModel> trainings;

  TrainingRecordListModel({
    required this.total,
    required this.trainings,
  });

  factory TrainingRecordListModel.fromJson(Map<String, dynamic> json) {
    return TrainingRecordListModel(
      total: json['total'],
      trainings: List<TrainingModel>.from(
        json['data'].map((training) => TrainingModel.fromJson(training)),
      ),
    );
  }
}
