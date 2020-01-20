import 'package:eni/web/auth_service.dart' as AuthService;

class Authenticate {
  Future signIn (String email, String password) async {
    return await AuthService.AuthService.loginUser(email, password);
  }
}