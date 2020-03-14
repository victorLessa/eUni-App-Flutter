import 'package:eni/web/user_service.dart';

class User {
  Future details(String token) async {
    var result = await UserService.detailsService(token);
    return result;
  }
}
