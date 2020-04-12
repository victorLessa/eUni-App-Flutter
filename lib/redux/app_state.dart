class AppState {
  final Map details;
  final String token;
  final List events;
  AppState({this.details, this.token, this.events});

  factory AppState.initialState() {
    return AppState(token: '', details: {}, events: []);
  }

  AppState copyWith({String token, Map details, List events}) {
    return AppState(
        token: token ?? this.token,
        details: details ?? this.details,
        events: events ?? this.events);
  }
}
