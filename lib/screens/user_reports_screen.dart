import 'package:flutter/material.dart';

import '../constants.dart';

class UserReportsScreen extends StatefulWidget {
  const UserReportsScreen({Key? key}) : super(key: key);

  static const routeName = '/user-reports-screen';

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          sizedBox10,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                'User Reports Export',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          sizedBox30,
        ],
      ),
    );
  }
}
