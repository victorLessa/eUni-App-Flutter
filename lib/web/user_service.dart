import 'package:http/http.dart' as http;
import 'package:eni/envairoment.dart';

final baseUrl = map['baseUrl'];

class UserService {
  static Future<http.Response> detailsService(String token) async {
    var result = await http.get('$baseUrl/users/details',
        headers: {"Authorization": 'Bearer $token'});
    return result;
  }
}
