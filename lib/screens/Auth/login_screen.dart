import 'package:expenso/screens/Auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../theme/themes.dart';
import '../home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final bool _loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: _loading
          ? loading
          : SafeArea(
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
                      kAuthBackgroundImage,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 350,
                    ),
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              ClassTextFormField(
                                imageName: kEmailIcon,
                                hintText: 'Email',
                                validator: (val) =>
                                    !isEmail(val!) ? 'Enter an email' : null,
                                onChanged: (val) {
                                  email = val;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ClassTextFormField(
                                isPassword: true,
                                imageName: kPasswordIcon,
                                hintText: 'Password',
                                validator: (val) => val!.length < 8
                                    ? 'Password min 8 characters'
                                    : null,
                                onChanged: (val) {
                                  password = val;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context,
                                        ForgotPasswordScreen.routeName);
                                  },
                                  child: const Text(
                                    'Forgot Password ?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              sizedBox30,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              3, 180, 253, 0.76),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          padding: const EdgeInsets.all(16.0)),
                                      onPressed: () async {
                                        Navigator.pushReplacementNamed(
                                            context, HomeScreen.routeName);
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
                              sizedBox50,
                              Row(children: const [
                                Expanded(
                                    child: Divider(
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                )),
                                sizedBox10,
                                Text(
                                  "or",
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                ),
                                sizedBox10,
                                Expanded(
                                    child: Divider(
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                )),
                              ]),
                              sizedBox30,
                              SizedBox(
                                width: 300,
                                child: OutlinedButton(
                                    onPressed: () async {},
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        side: const BorderSide(
                                            width: 2.0,
                                            color: Color.fromRGBO(
                                                196, 196, 196, 1)),
                                        padding: const EdgeInsets.all(16.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Image(image: AssetImage(kGoogleIcon)),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  60, 90, 154, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway'),
                                        ),
                                      ],
                                    )),
                              ),
                              sizedBox30,
                              ClassicTextButton(
                                leading: 'Don’t have an account?',
                                title: 'Sign up',
                                handler: () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterScreen.routeName);
                                },
                              ),
                              sizedBox50
                            ],
                          ),
                        ))
                  ],
                )
              ],
            )),
    );
  }
}
