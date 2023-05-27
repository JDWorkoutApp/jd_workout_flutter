import 'package:workout_app/models/training_summary_model.dart';

class TrainingRecordSummaryListModel {
  final int total;
  final List<TrainingSummaryModel> trainings;

  TrainingRecordSummaryListModel({
    required this.total,
    required this.trainings,
  });

  factory TrainingRecordSummaryListModel.fromJson(Map<String, dynamic> json) {
    return TrainingRecordSummaryListModel(
      total: json['total'],
      trainings: List<TrainingSummaryModel>.from(
        json['data'].map((training) => TrainingSummaryModel.fromJson(training)),
      ),
    );
  }
}
