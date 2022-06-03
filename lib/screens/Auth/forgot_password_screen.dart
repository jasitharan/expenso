import 'package:expenso/shared/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../Auth/forgot_password_success_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot-password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: mediaQuery.size.width,
                child: SvgPicture.asset(
                  kAuthBackgroundSvg,
                  fit: BoxFit.fill,
                  height: 690,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 16),
                child: Image.asset(
                  'assets/images/login_background.png',
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Forget Password ?',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 32),
                    child: InputTextField(
                      iconName: 'assets/images/email2PrefixIcon.png',
                      hintText: 'Email',
                      initialValue: email,
                      color: Colors.grey,
                      validator: (val) =>
                          !isEmail(val) ? 'Enter an email' : null,
                      onChanged: (val) {
                        email = val;
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
                          'Send reset link',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
