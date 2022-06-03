import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import 'Auth/login_screen.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);
  static const routeName = '/gettingstarted-screen';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: mediaQuery.size.width,
              child: SvgPicture.asset(
                kAuthBackgroundSvg,
                fit: BoxFit.fill,
                height: 690,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 100),
                child: Image.asset('assets/images/back_image.png'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 80.0, left: 8, right: 8),
                    child: AutoSizeText(
                      "EXPENSO",
                      maxLines: 1,
                      minFontSize: 64,
                      style: TextStyle(
                          fontSize: 72,
                          color: Color.fromRGBO(105, 105, 105, 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 64.0),
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
                            'Get Start',
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
