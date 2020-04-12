import 'dart:convert';

import 'package:eni/web/events_service.dart';
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
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      if (response.statusCode == 401) {
        final data = json.decode(response.body);
        throw Exception(data[0]['message']);
      } else if (response.statusCode == 500) {
        throw Exception('Internal server Error');
      }
    }
  }
}
