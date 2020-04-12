import 'package:eni/web/events_service.dart';

class Events {
  static Future<dynamic> getEventsByDate(date, token) async {
    final result = await EventsService().getEvents(date, token);
    return result;
  }
}
