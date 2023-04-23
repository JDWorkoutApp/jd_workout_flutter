import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static Future<Map<String, dynamic>> get(int page) async {
    return {
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
  }
}
