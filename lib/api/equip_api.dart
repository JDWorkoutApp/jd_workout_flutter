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
      ]
    };
  }

  static Future<bool> putWeight(int id, List<int> weights) async {
    return true;
  }
}