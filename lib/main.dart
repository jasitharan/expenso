import 'package:expenso/screens/getting_started_screen.dart';
import 'package:expenso/screens/login_screen.dart';
import 'package:expenso/screens/register_screen.dart';
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
        RegisterScreen.routeName: (ctx) => const RegisterScreen()
      },
    );
  }
}
