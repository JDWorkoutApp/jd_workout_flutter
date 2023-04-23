import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrainingData {
  final int total;
  final List<Training> trainings;

  TrainingData({
    required this.total,
    required this.trainings,
  });

  factory TrainingData.fromJson(Map<String, dynamic> json) {
    return TrainingData(
      total: json['total'],
      trainings: List<Training>.from(
        json['data'].map((training) => Training.fromJson(training)),
      ),
    );
  }
}

class Training {
  final String date;
  final String start;
  final String end;
  final List<Equipment> equipments;

  Training({
    required this.date,
    required this.start,
    required this.end,
    required this.equipments,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      date: json['date'],
      start: json['start'],
      end: json['end'],
      equipments: List<Equipment>.from(
        json['equips'].map((equipment) => Equipment.fromJson(equipment)),
      ),
    );
  }
}

class Equipment {
  final int id;
  final String name;
  final String note;
  final List<Record> records;

  Equipment({
    required this.id,
    required this.name,
    required this.note,
    required this.records,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      records: List<Record>.from(
        json['records'].map((record) => Record.fromJson(record)),
      ),
    );
  }
}

class Record {
  final int id;
  final int weight;
  final int reps;
  final int sets;
  final List<String> notes;

  Record({
    required this.id,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.notes,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      weight: json['weight'],
      reps: json['reps'],
      sets: json['sets'],
      notes: List<String>.from(json['notes']),
    );
  }
}


class RecordApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<bool> store(
      int equipId, double weight, int reps, String note) async {
    return true;
  }

  static Future<bool> patch(
      int id, int equipId, double weight, int reps, String note) async {
    return true;
  }

  static Future<bool> delete(int id) async {
    return true;
  }

  static Future<TrainingData> get(int page) async {
    Map<String, dynamic> json = {
      "total": 55,
      "data": [
        {
          "date": "2021-05-01",
          "start": "10:00:00",
          "end": "11:00:00",
          "equips": [
            {
              "id": 11,
              "name": "Bench Press",
              "note": "Note for bench press",
              "records": [
                {
                  "id": 1,
                  "weight": 200,
                  "reps": 10,
                  "sets": 3,
                  "notes": ["tired", "good", "bad"],
                }
              ]
            }
          ]
        },
        {
          "date": "2021-05-02",
          "start": "10:00:00",
          "end": "11:00:00",
          "equips": [
            {
              "id": 11,
              "name": "Bench Press",
              "note": "Note for bench press",
              "records": [
                {
                  "id": 1,
                  "weight": 200,
                  "reps": 10,
                  "sets": 3,
                  "notes": ["tired", "good", "bad"],
                }
              ]
            }
          ]
        },
        {
          "date": "2021-05-03",
          "start": "10:00:00",
          "end": "11:00:00",
          "equips": [
            {
              "id": 11,
              "name": "Bench Press",
              "note": "Note for bench press",
              "records": [
                {
                  "id": 1,
                  "weight": 200,
                  "reps": 10,
                  "sets": 3,
                  "notes": ["tired", "good", "bad"],
                }
              ]
            }
          ]
        },
      ]
    };

    TrainingData trainingData = TrainingData.fromJson(json);

    return trainingData;
  }
}
