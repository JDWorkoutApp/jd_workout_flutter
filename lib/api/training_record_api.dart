import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workout_app/models/training_record_list_model.dart';
import 'package:workout_app/utils/api_client.dart';

class TrainingRecordApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<bool> store(
      int equipId, double weight, double reps, String note) async {
      final response = await ApiClient().post(ApiClient.getUri('/record/'), body: {
        'equip_id': equipId.toString(),
        'weight': weight.toString(),
        'reps': reps.toString(),
        'note': note,
      });

    var code = response.statusCode;

    if (code != 200) {
      throw Exception("Error when storing training record");
    }

    return true;
  }

  static Future<bool> patch(
      int id, int equipId, double weight, int reps, String note) async {
    return true;
  }

  static Future<bool> delete(int id) async {
    return true;
  }

  static Future<TrainingRecordListModel> getDaySummaryList(int page) async {
    final response = await ApiClient().get(ApiClient.getUri('/record/day-summary?perPage=30&currentPage=$page'));
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);

    TrainingRecordListModel trainingData = TrainingRecordListModel.fromJson(json);

    return trainingData;
  }
}
