import '../repository/auth/auth_repo.dart';
import '../repository/auth/api/api_auth_repo.dart';
import 'models/user_model.dart';

class AuthProvider {
  final AuthRepo _authRepo = ApiAuthRepo();

  UserModel? _userFromServer(dynamic user) {
    return user != null
        ? UserModel(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  Stream<UserModel?> get user {
    return _authRepo.getUser().map(_userFromServer);
  }

  Future<UserModel?> register(
      String email, String password, String name, String phoneNumber) async {
    dynamic user = await _authRepo.registerNewUser(
      name,
      phoneNumber,
      email,
      password,
    );
    return _userFromServer(user);
  }

  Future<UserModel?> signIn(String email, String password) async {
    dynamic user = await _authRepo.signIn(email, password);
    return _userFromServer(user);
  }

  Future<UserModel?> signInWithGoogle() async {
    dynamic user = await _authRepo.signInWithGoogle();
    return _userFromServer(user);
  }

  Future<UserModel?> signInWithApple() async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }

  Future forgotPassword(String email) async {
    return await _authRepo.forgotPassword(email);
  }

  Future resetPassword(String email, String code, String password) async {
    return await _authRepo.resetPassword(email, code, password);
  }
}
