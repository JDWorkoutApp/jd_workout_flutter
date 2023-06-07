import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
    final response = await ApiClient().patch(ApiClient.getUri('/equip/$id'),
        body: {'name': name, 'note': note});

    if (response.statusCode != 200) {
      throw Exception('Failed update');
    }

    return true;
  }

  static Future<bool> updateWeights(int id, List<double> weights) async {
    final response = await ApiClient().put(ApiClient.getUri('/equip/$id/weight'),
        body: {'weights': jsonEncode(weights) });

    if (response.statusCode != 200) {
      throw Exception('Failed update');
    }

    return true;
  }

  static Future<bool> uploadImage(int id, CroppedFile image) async {
    var request =
        http.MultipartRequest('PATCH', ApiClient.getUri('/equip/$id'));

    var imageBytes = await image.readAsBytes();
    var file = http.MultipartFile.fromBytes('image', imageBytes,
        filename: image.path.split('/').last + '.jpg',
        contentType: MediaType('image', 'jpeg'));

    request.files.add(file);

    var response = await ApiClient().send(request);
    if (response.statusCode != 200) {
      throw Exception('Failed upload');
    }

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