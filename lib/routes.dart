import 'package:expenso/screens/Auth/wrapper.dart';
import 'package:expenso/screens/home_pages/expenses_screen.dart';
import 'package:expenso/screens/user_reports_screen.dart';
import 'package:flutter/material.dart';

import 'package:expenso/screens/Auth/forgot_password_screen.dart';
import 'package:expenso/screens/Auth/reset_password_screen.dart';
import 'package:expenso/screens/Auth/reset_password_success.dart';
import 'package:expenso/screens/getting_started_screen.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      '/': (ctx) => const GettingStartedScreen(),
      Wrapper.routeName: (ctx) => const Wrapper(),
      GettingStartedScreen.routeName: (ctx) => const GettingStartedScreen(),
      ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
      ResetPasswordScreen.routeName: (ctx) => const ResetPasswordScreen(),
      ResetPasswordSuccessScreen.routeName: (ctx) =>
          const ResetPasswordSuccessScreen(),
      ExpensesScreen.routeName: (ctx) => const ExpensesScreen(),
      UserReportsScreen.routeName: (ctx) => const UserReportsScreen(),
    };
