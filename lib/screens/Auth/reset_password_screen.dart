import 'package:expenso/screens/Auth/forgot_password_success_screen.dart';
import 'package:expenso/shared/input_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/reset-password-screen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String password = '';

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
                  'Reset Password',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 32),
                  child: InputTextField(
                    initialValue: password,
                    iconName: 'assets/images/password2PrefixIcon.png',
                    hintText: 'Password',
                    isPassword: true,
                    validator: (val) =>
                        val!.length < 8 ? 'Password min 8 characters' : null,
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 24),
                  child: InputTextField(
                    initialValue: password,
                    iconName: 'assets/images/password2PrefixIcon.png',
                    hintText: 'Confirm Password',
                    isPassword: true,
                    validator: (val) =>
                        val!.length < 8 ? 'Password min 8 characters' : null,
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(3, 180, 253, 0.76),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          padding: const EdgeInsets.all(16.0)),
                      onPressed: () async {
                        Navigator.pushReplacementNamed(
                            context, ForgotPasswordSuccessScreen.routeName);
                      },
                      child: const Text(
                        'Update Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      )),
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
