import 'package:expenso/screens/Auth/forgot_password_screen.dart';
import 'package:expenso/screens/Auth/forgot_password_success_screen.dart';
import 'package:expenso/screens/Auth/login_screen.dart';
import 'package:expenso/screens/Auth/register_screen.dart';
import 'package:expenso/screens/Auth/register_success_screen.dart';
import 'package:expenso/screens/Auth/reset_password_screen.dart';
import 'package:expenso/screens/Auth/reset_password_success.dart';
import 'package:expenso/screens/getting_started_screen.dart';
import 'package:expenso/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenso',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GettingStartedScreen(),
      routes: {
        GettingStartedScreen.routeName: (ctx) => const GettingStartedScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        RegisterSuccessScreen.routeName: (ctx) => const RegisterSuccessScreen(),
        ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
        ForgotPasswordSuccessScreen.routeName: (ctx) =>
            const ForgotPasswordSuccessScreen(),
        ResetPasswordScreen.routeName: (ctx) => const ResetPasswordScreen(),
        ResetPasswordSuccessScreen.routeName: (ctx) =>
            const ResetPasswordSuccessScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen()
      },
    );
  }
}
