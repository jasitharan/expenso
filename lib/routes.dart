import 'package:expenso/screens/Auth/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:expenso/screens/Auth/forgot_password_screen.dart';
import 'package:expenso/screens/Auth/forgot_password_success_screen.dart';
import 'package:expenso/screens/Auth/login_screen.dart';
import 'package:expenso/screens/Auth/register_screen.dart';
import 'package:expenso/screens/Auth/register_success_screen.dart';
import 'package:expenso/screens/Auth/reset_password_screen.dart';
import 'package:expenso/screens/Auth/reset_password_success.dart';
import 'package:expenso/screens/getting_started_screen.dart';
import 'package:expenso/screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      '/': (ctx) => const GettingStartedScreen(),
      Wrapper.routeName: (ctx) => const Wrapper(),
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
    };
