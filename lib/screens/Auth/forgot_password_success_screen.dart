import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  const ForgotPasswordSuccessScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot-password-success-screen';

  @override
  _ForgotPasswordSuccessScreenState createState() =>
      _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState
    extends State<ForgotPasswordSuccessScreen> {
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
                    'Check your email',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'The password was sent to the separate email',
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
          ],
        ),
      ),
    );
  }
}
