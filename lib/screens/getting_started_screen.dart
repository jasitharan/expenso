import 'package:expenso/screens/login_screen.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);
  static const routeName = '/gettingstarted-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gettingStarted.png"),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text(
                    "EXPENSO",
                    style: TextStyle(
                        fontSize: 72, color: Color.fromRGBO(105, 105, 105, 1)),
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
        ),
      ),
    );
  }
}
