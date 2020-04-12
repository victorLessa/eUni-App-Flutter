import 'package:redux/redux.dart';
import 'package:eni/redux/app_reducer.dart';
import 'package:eni/redux/app_state.dart';

Store<AppState> appStore =
    Store<AppState>(appReducer, initialState: AppState.initialState());
