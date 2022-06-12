abstract class AuthRepo {
  Future registerNewUser(
      String name, String phoneNumber, String email, String password);

  Future signIn(String email, String password);

  Future forgotPassword(String email);

  Future resetPassword(String email, String code, String password);

  Future signOut();

  Stream getUser();

  Future updateProfile(
    String? email,
    String? name,
    String? phoneNumber,
    String? image,
    String token,
  );
}
