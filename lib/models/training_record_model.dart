class TrainingRecordModel {
  final int id;
  final int weight;
  final int reps;
  final int sets;
  final List<String> notes;

  TrainingRecordModel({
    required this.id,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.notes,
  });

  factory TrainingRecordModel.fromJson(Map<String, dynamic> json) {
    return TrainingRecordModel(
      id: json['id'],
      weight: json['weight'],
      reps: json['reps'],
      sets: json['sets'],
      notes: List<String>.from(json['notes']),
    );
  }
}
