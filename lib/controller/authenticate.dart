import 'package:eni/web/auth_service.dart' as AuthService;

class Authenticate {
  Future signIn(String email, String password) async {
    var result;
    try {
      result = await AuthService.AuthService.loginUser(email, password);
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }
}
