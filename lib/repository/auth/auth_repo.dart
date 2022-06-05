import 'package:the_apple_sign_in/the_apple_sign_in.dart';

abstract class AuthRepo {
  Future registerNewUser(
      String name, String phoneNumber, String email, String password);

  Future signIn(String email, String password);

  Future signInWithGoogle();

  Future signInWithApple({List<Scope> scopes = const []});

  Future forgotPassword(String email);

  Future resetPassword(String email, String code, String password);

  Future signOut();

  Stream getUser();
}
