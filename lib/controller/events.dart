import 'package:eni/web/events_service.dart';

class Events {
  static Future<dynamic> getEventsByDate(date) async {
    final result = await EventsService().getEvents(date);
    return result;
  }
}
