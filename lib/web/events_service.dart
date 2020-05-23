import 'package:http/http.dart' as http;

import 'package:eni/envairoment.dart';

final baseUrl = map['baseUrl'];

class EventsService {
  Future<dynamic> getEvents(date, token) async {
    final result = await http.get('$baseUrl/events/getEventByDay/$date',
        headers: {"Authorization": 'Bearer $token'});
    return result;
  }
}
