import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenso/screens/Auth/wrapper.dart';
import 'package:expenso/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: mediaQuery.size.width,
                child: SvgPicture.asset(
                  kBackgroundSvg,
                  fit: BoxFit.fill,
                  height: 690,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 120),
                child: Image.asset(kGettingStartedImage),
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
                      child: ClassicButton(
                        handler: () async {
                          Navigator.pushReplacementNamed(
                            context,
                            Wrapper.routeName,
                          );
                        },
                        title: 'Get Start',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
