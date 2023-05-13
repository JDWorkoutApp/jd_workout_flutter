import '../constants/api_constants.dart';
class ApiHelper {
    static Uri getUri(String path) {
        return Uri.parse('${APIConstants.apiPath}$path');
    }
}