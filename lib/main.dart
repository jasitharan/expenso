import 'package:flutter/material.dart';
import 'package:expenso/routes.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'providers/auth_provider.dart';
import 'providers/models/user_model.dart';
import 'repository/auth/api/auth_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthApi.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthProvider().user,
      initialData: null,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: kAppName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: getRoutes()),
    );
  }
}
