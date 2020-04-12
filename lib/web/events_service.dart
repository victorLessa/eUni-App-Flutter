import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eni/redux/app_store.dart';

final baseUrl = 'https://api-uni.herokuapp.com';

class EventsService {
  Future<dynamic> getEvents(date, token) async {
    final result = await http.get('$baseUrl/events/getEventByDay/$date',
        headers: {"Authorization": 'Bearer $token'});
    return result;
  }
}
