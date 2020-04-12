import 'package:eni/redux/app_state.dart';
import 'package:eni/redux/app_actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action['type'] is SaveUser) {
    return state.copyWith(
        token: action['data']['token'], details: action['data']);
  } else if (action['type'] is SavePopularEvents) {
    return state.copyWith(events: action['data']);
  }
  return state;
}
