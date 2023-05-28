import 'equip_model.dart';

class TrainingRecordModel {
  final int id;
  final int weight;
  final int reps;
  final int sets;
  final List<String>? notes;
  String? note;
  EquipModel? equip;

  TrainingRecordModel({
    required this.id,
    required this.weight,
    required this.reps,
    required this.sets,
    this.notes,
    this.note,
    this.equip,
  });

  factory TrainingRecordModel.fromJson(Map<String, dynamic> json) {
    return TrainingRecordModel(
      id: json['id'],
      weight: json['weight'],
      reps: json['reps'],
      sets: json['sets'],
      notes: json['notes'] != null ? List<String>.from(json['notes']) : null,
      note: json['note'],
      equip: json['equip'] != null ? EquipModel.fromJson(json['equip']) : null,
    );
  }
}
