import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../env.dart';
import '../auth_repo.dart';
import 'auth_api.dart';
import 'models/api_user_model.dart';

class ApiAuthRepo implements AuthRepo {
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
    String name,
    String phoneNumber,
    String email,
    String password,
    DateTime dob,
    String company,
    String address,
    String city,
    String province,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'phoneNumber': phoneNumber,
          'company_id': company,
          'address': address,
          'city': city,
          'province': province,
          'country': 'Srilanka',
          'email': email,
          'dob': dob.toString(),
          'password': password,
          'password_confirmation': password,
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
    } catch (e) {
      return null;
    }
  }

  @override
  Future signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        ApiUserModel apiUserModel = ApiUserModel.fromJson(response.body);
        controller.add(apiUserModel);
        userInstance = apiUserModel;
        AuthApi.setAuth(userInstance);
        return apiUserModel;
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  @override
  Future signOut() async {
    try {
      final response = await http
          .post(Uri.parse('$kApiUrl/logout'), headers: <String, String>{
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
    } catch (e) {
      return null;
    }
  }

  @override
  Future forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/forgot-password'),
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
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future resetPassword(String email, String code, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/reset-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'token': code,
          'password': password,
          'password_confirmation': password
        }),
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else if (response.statusCode == 404) {
        return response.statusCode;
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }

  @override
  Stream<ApiUserModel?> getUser() {
    return controller.stream;
  }

  @override
  Future updateProfile(
      Map<String, dynamic>? data, String? image, String token) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse('$kApiUrl/updateDetail'),
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);

      if (image != null) {
        request.files.add(http.MultipartFile('url_image',
            File(image).readAsBytes().asStream(), File(image).lengthSync(),
            filename: image.split("/").last));
      }

      if (data != null) {
        data.forEach((key, value) {
          request.files.add(http.MultipartFile.fromString(
            key,
            value.toString(),
          ));
        });
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        if (respStr.isNotEmpty) {
          ApiUserModel apiUserModel = ApiUserModel.fromJson(respStr);
          apiUserModel.uid = userInstance!.uid;

          controller.add(apiUserModel);
          userInstance = apiUserModel;
          AuthApi.setAuth(userInstance);
          return apiUserModel;
        }
      } else if (response.statusCode == 404) {
        return response.statusCode;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future sendVerificationEmail(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/email/verification-notification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else if (response.statusCode == 404) {
        return response.statusCode;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future verifyEmail(String token, String id, String code) async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/verify-email/$id/$code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        userInstance!.isVerified = true;
        AuthApi.setAuth(userInstance);
        controller.add(userInstance);
        return response.statusCode;
      } else if (response.statusCode == 404) {
        return response.statusCode;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
