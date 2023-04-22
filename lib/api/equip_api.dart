import 'package:flutter_dotenv/flutter_dotenv.dart';

class EquipApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<bool> store(String name, String note) async {
    return true;
  }

  static Future<bool> patch(int id, String name, String note) async {
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
          "id": 11,
          "name": "Bench Press",
          "note": "Note for bench press",
        },
        {
          "id": 12,
          "name": "Pull equip",
          "note": "Note for Pull equip",
        },
        {
          "id": 13,
          "name": "Leg equip",
          "note": "Note for Leg equip",
        },
        {
          "id": 14,
          "name": "equip....",
          "note": ".............",
        },
        {
          "id": 15,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 16,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 17,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 18,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 19,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 20,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 21,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 22,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 23,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 24,
          "name": "test equip",
          "note": "test note",
        },
        {
          "id": 25,
          "name": "test equip",
          "note": "test note",
        },
      ]
    };
  }

  static Future<bool> putWeight(int id, List<double> weights) async {
    return true;
  }
}