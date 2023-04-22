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
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 12,
          "name": "Pull equip",
          "note": "Note for Pull equip",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 13,
          "name": "Leg equip",
          "note": "Note for Leg equip",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 14,
          "name": "equip....",
          "note": ".............",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 15,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 16,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 17,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 18,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 19,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 20,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 21,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 22,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 23,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 24,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
        {
          "id": 25,
          "name": "test equip",
          "note": "test note",
          "weights": [200, 1.0, 2.1, 3.3, 4.4, 5.0, 6],
        },
      ]
    };
  }

  static Future<bool> putWeight(int id, List<double> weights) async {
    return true;
  }
}