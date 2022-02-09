import 'package:flutter/material.dart';

class ResetPasswordSuccessScreen extends StatefulWidget {
  const ResetPasswordSuccessScreen({Key? key}) : super(key: key);

  static const routeName = '/reset-password-success-screen';

  @override
  _ResetPasswordSuccessScreenState createState() =>
      _ResetPasswordSuccessScreenState();
}

class _ResetPasswordSuccessScreenState
    extends State<ResetPasswordSuccessScreen> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Password reset',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Your password has been changed successfully',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(children: const [
                  Expanded(
                      child: Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  )),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Back to',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
