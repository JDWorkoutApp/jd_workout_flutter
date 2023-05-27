import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workout_app/models/equip_summary_list_model.dart';
import 'package:workout_app/utils/api_client.dart';

class EquipApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<bool> store(String name, String note) async {
    final response = await ApiClient().post(ApiClient.getUri('/equip/'), body: {
      'name': name,
      'note': note,
    });

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<bool> patch(int id, String name, String note) async {
    return true;
  }

  static Future<bool> delete(int id) async {
    final response = await ApiClient().delete(ApiClient.getUri('/equip/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed delete');
    }

    return true;
  }

  static Future<EquipSummaryListModel> get(int page) async {
    final response = await ApiClient().get(ApiClient.getUri('/equip/?perPage=30&currentPage=$page'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load equips');
    }

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);

    EquipSummaryListModel list = EquipSummaryListModel.fromJson(data);

    return list;
  }

  static Future<bool> putWeight(int id, List<double> weights) async {
    return true;
  }
}