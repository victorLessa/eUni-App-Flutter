import 'dart:convert';

import 'package:http/http.dart' as http;

final baseUrl = 'https://api-uni.herokuapp.com';

class AuthService {
  static Future<http.Response> loginUser(String email, String password) async {
    var data = jsonEncode({
      "email": email.trim().toLowerCase(),
      "password": password,
    });

    var result = await http.post('$baseUrl/signIn',
        body: data, headers: {"Content-Type": "application/json"});

    return result;
  }
}
