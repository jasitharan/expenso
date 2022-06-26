abstract class AuthRepo {
  Future registerNewUser(
    String name,
    String phoneNumber,
    String email,
    String password,
    DateTime dob,
    String company,
    String address,
    String city,
    String northern,
  );

  Future signIn(
    String email,
    String password,
  );

  Future forgotPassword(
    String email,
  );

  Future resetPassword(
    String email,
    String code,
    String password,
  );

  Future signOut();

  Stream getUser();

  Future updateProfile(
    Map<String, dynamic>? data,
    String? image,
    String token,
  );

  Future sendVerificationEmail(
    String token,
  );

  Future verifyEmail(
    String token,
    String id,
    String code,
  );
}
