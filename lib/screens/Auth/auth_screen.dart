import 'package:expenso/screens/Auth/login_screen.dart';
import 'package:expenso/screens/Auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleAuth() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(
            toggleAuth: toggleAuth,
          )
        : RegisterScreen(
            toggleAuth: toggleAuth,
          );
  }
}
