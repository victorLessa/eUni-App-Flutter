import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eni/envairoment.dart';

final baseUrl = map['baseUrl'];

class AuthService {
  static Future<http.Response> loginUser(String email, String password) async {
    var data = jsonEncode({
      "email": email.trim().toLowerCase(),
      "password": password,
    });
    var result;
    try {
      result = await http.post('$baseUrl/signIn',
          body: data, headers: {"Content-Type": "application/json"});
    } catch (e) {
      throw Exception(e);
    }

    return result;
  }

  static Future<http.Response> register(
      String email, String username, String password) async {
    var data = jsonEncode({
      "email": email.trim().toLowerCase(),
      "password": password,
      "username": username
    });
    final response = await http.post('$baseUrl/users',
        body: data, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return response;
    } else {
      if (response.statusCode == 401) {
        final data = json.decode(response.body);
        throw Exception(data[0]['message']);
      } else if (response.statusCode == 500) {
        throw Exception('Internal server Error');
      }
    }
    return response;
  }
}
