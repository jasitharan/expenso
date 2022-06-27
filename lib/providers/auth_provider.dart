import 'package:firebase_messaging/firebase_messaging.dart';

import '../repository/auth/api/auth_api.dart';
import '../repository/auth/auth_repo.dart';
import '../repository/auth/api/api_auth_repo.dart';
import 'models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider {
  final AuthRepo _authRepo = ApiAuthRepo();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  AuthProvider() {
    if (AuthApi.getApiUserModel() != null) {
      messaging.subscribeToTopic(AuthApi.getApiUserModel()!.id!);
    }
  }

  UserModel? _userFromServer(dynamic user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            id: user.id,
            isVerified: user.isVerified,
            email: user.email,
            name: user.displayName,
            imageUrl: user.imageUrl,
            phoneNumber: user.phoneNumber,
            dob: user.dob,
            address: user.address,
            city: user.city,
            province: user.province,
            country: user.country,
            bankName: user.bankName,
            bankNumber: user.bankNumber,
            bankBranch: user.bankBranch,
            companyName: user.companyName,
          )
        : null;
  }

  Stream<UserModel?> get user {
    return _authRepo.getUser().map(_userFromServer);
  }

  Future<UserModel?> register(
    String email,
    String password,
    String name,
    String phoneNumber,
    DateTime dob,
    String company,
    String address,
    String city,
    String northern,
  ) async {
    dynamic user = await _authRepo.registerNewUser(
      name,
      phoneNumber,
      email,
      password,
      dob,
      company,
      address,
      city,
      northern,
    );
    UserModel? result = _userFromServer(user);

    // For Notifications
    if (result != null) {
      await messaging.subscribeToTopic(result.id);
    }

    return result;
  }

  Future<UserModel?> signIn(String email, String password) async {
    dynamic user = await _authRepo.signIn(email, password);

    UserModel? result = _userFromServer(user);

    // For Notifications
    if (result != null) {
      await messaging.subscribeToTopic(result.id);
    }

    return result;
  }

  Future<void> signOut(String id) async {
    await messaging.unsubscribeFromTopic(id);
    await _authRepo.signOut();
  }

  Future forgotPassword(String email) async {
    return await _authRepo.forgotPassword(email);
  }

  Future resetPassword(String email, String code, String password) async {
    return await _authRepo.resetPassword(email, code, password);
  }

  Future sendVerificationEmail(String token) async {
    return await _authRepo.sendVerificationEmail(token);
  }

  Future verifyEmail(String token, String id, String code) async {
    return await _authRepo.verifyEmail(token, id, code);
  }

  Future updateProfile(Map<String, dynamic>? data, ImageSource? imageSource,
      String token) async {
    String? image;
    if (imageSource != null) {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        image = pickedFile.path;
      }
    }

    var result = await _authRepo.updateProfile(data, image, token);

    return result;
  }
}
