import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../constants.dart';
import '../auth_repo.dart';
import 'auth_api.dart';
import 'models/api_user_model.dart';

class ApiAuthRepo implements AuthRepo {
  static const String baseUrl = kApiUrl;
  final controller = StreamController<ApiUserModel?>();

  ApiUserModel? userInstance;

  ApiAuthRepo() {
    setUserFromAuthApi(AuthApi.getApiUserModel());
  }

  void setUserFromAuthApi(ApiUserModel? user) {
    userInstance = user;
    controller.add(userInstance);
  }

  @override
  Future registerNewUser(
      String name, String phoneNumber, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'password_confirmation': password
      }),
    );

    if (response.statusCode == 201) {
      ApiUserModel apiUserModel = ApiUserModel.fromJson(response.body);
      controller.add(apiUserModel);
      userInstance = apiUserModel;
      AuthApi.setAuth(userInstance);
      return apiUserModel;
    } else {
      return null;
    }
  }

  @override
  Future signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      ApiUserModel apiUserModel = ApiUserModel.fromJson(response.body);
      controller.add(apiUserModel);
      userInstance = apiUserModel;
      AuthApi.setAuth(userInstance);
      return apiUserModel;
    } else {
      return null;
    }
  }

  @override
  Future signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future signInWithApple({List<Scope> scopes = const []}) {
    throw UnimplementedError();
  }

  @override
  Future signOut() async {
    final response =
        await http.post(Uri.parse('$baseUrl/logout'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userInstance!.uid}',
    });

    if (response.statusCode == 200) {
      userInstance = null;
      controller.add(null);
      AuthApi.clearAuth();
      return 1;
    } else {
      return null;
    }
  }

  @override
  Future forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 404) {
      return response.statusCode;
    } else {
      throw Exception(['Failed to send.', response.body]);
    }
  }

  @override
  Stream<ApiUserModel?> getUser() {
    return controller.stream;
  }
}
