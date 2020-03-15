import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final baseUrl = 'https://api-uni.herokuapp.com';

class EventsService {
  Future<dynamic> getEvents(date) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final result = await http.get('$baseUrl/events/getEventByDay/$date',
        headers: {"Authorization": 'Bearer $token'});
    return result;
  }
}
