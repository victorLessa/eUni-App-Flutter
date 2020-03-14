import 'package:http/http.dart' as http;

String baseUrl = 'https://api-uni.herokuapp.com';

class UserService {
  static Future<http.Response> detailsService(String token) async {
    var result = await http.get('$baseUrl/users/details',
        headers: {"Authorization": 'Bearer $token'});
    return result;
  }
}
