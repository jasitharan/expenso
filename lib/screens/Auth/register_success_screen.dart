import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'login_screen.dart';

class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({Key? key}) : super(key: key);

  static const routeName = '/register-success-screen';

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
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
                    height: 125,
                  ),
                  const Image(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/check.png')),
                  const SizedBox(height: 10),
                  const Text(
                    'Thank you for registering !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
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
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
