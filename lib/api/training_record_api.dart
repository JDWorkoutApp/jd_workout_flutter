import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workout_app/models/training_record_summary_list_model.dart';
import 'package:workout_app/utils/api_client.dart';

import '../models/traning_record/training_record_list.dart';

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
      int id, int equipId, double weight, double reps, String note) async {
    final response = await ApiClient().patch(ApiClient.getUri('/record/$id'),
        body: {
          'equip_id': equipId.toString(),
          'weight': weight.toString(),
          'reps': reps.toString(),
          'note': note,
        });

    if (response.statusCode != 200) {
      throw Exception('Failed update');
    }

    return true;
  }

  static Future<bool> delete(int id) async {
    final response = await ApiClient().delete(ApiClient.getUri('/record/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed delete');
    }

    return true;
  }

  static Future<TrainingRecordSummaryListModel> getDaySummaryList(int page) async {
    final response = await ApiClient().get(ApiClient.getUri('/record/day-summary?perPage=30&currentPage=$page'));
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);

    TrainingRecordSummaryListModel trainingData = TrainingRecordSummaryListModel.fromJson(json);

    return trainingData;
  }

  static Future<TrainingRecordListModel> get(int page) async {
    final response = await ApiClient().get(
        ApiClient.getUri('/record/?perPage=30&currentPage=$page'));
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);

    TrainingRecordListModel trainingData =
        TrainingRecordListModel.fromJson(json);

    return trainingData;
  }
}
