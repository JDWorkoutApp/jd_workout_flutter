class EquipRecordsModel {
  List<int> ids;
  int weight;
  int reps;
  int sets;
  List<String> ?note;

  EquipRecordsModel({
    required this.ids,
    required this.weight,
    required this.reps,
    required this.sets,
    this.note,
  });

factory EquipRecordsModel.fromJson(Map<String, dynamic> json) {
    return EquipRecordsModel(
      ids: json['ids'].cast<int>(),
      weight: json['weight'],
      reps: json['reps'],
      sets: json['sets'],
      note: json['note'].cast<String>(),
    );
  }
}
