import 'package:expenso/providers/company_provider.dart';
import 'package:expenso/providers/expense_provider.dart';
import 'package:expenso/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'constants.dart';
import 'providers/auth_provider.dart';
import 'providers/expense_type_provider.dart';
import 'providers/models/user_model.dart';
import 'repository/auth/api/auth_api.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'Hight Importance Notifications', //title
    importance: Importance.high, //
    playSound: true);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthApi.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: Colors.blue,
                    playSound: true,
                    icon: "@mipmap/ic_launcher")));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: AuthProvider()),
        Provider.value(value: ExpenseProvider()),
        Provider.value(value: ExpenseTypeProvider()),
        Provider.value(value: CompanyProvider()),
      ],
      builder: (context, child) => StreamProvider<UserModel?>.value(
        initialData: null,
        value: Provider.of<AuthProvider>(context, listen: false).user,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: kAppName,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: getRoutes()),
      ),
    );
  }
}
