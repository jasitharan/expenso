import 'package:expenso/screens/Auth/register_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../shared/input_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  String phoneNumber = '';
  final bool _loading = false;

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
                        'assets/images/login_background.png',
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 100.0,
                                  ),
                                  InputTextField(
                                    initialValue: name,
                                    iconName:
                                        'assets/images/userPrefixIcon.png',
                                    color: Colors.grey,
                                    hintText: 'Name',
                                    validator: (val) {
                                      final temp =
                                          val.toString().split(' ').join();
                                      return !isAlpha(temp)
                                          ? 'Enter an name'
                                          : null;
                                    },
                                    onChanged: (val) {
                                      name = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InputTextField(
                                    initialValue: email,
                                    iconName:
                                        'assets/images/emailPrefixIcon.png',
                                    hintText: 'Email',
                                    validator: (val) =>
                                        !isEmail(val) ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      email = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InputTextField(
                                    initialValue: phoneNumber,
                                    iconName:
                                        'assets/images/phonePrefixIcon.png',
                                    hintText: 'Phone',
                                    validator: (val) => !isNumeric(val)
                                        ? 'Enter an phone number'
                                        : null,
                                    onChanged: (val) {
                                      phoneNumber = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InputTextField(
                                    initialValue: password,
                                    iconName:
                                        'assets/images/passwordPrefixIcon.png',
                                    hintText: 'Password',
                                    isPassword: true,
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
                                  InputTextField(
                                    initialValue: confirmPassword,
                                    iconName:
                                        'assets/images/passwordPrefixIcon.png',
                                    hintText: 'Confirm Password',
                                    isPassword: true,
                                    validator: (val) {
                                      return password == val
                                          ? null
                                          : 'Passwords not match';
                                    },
                                    onChanged: (val) {
                                      confirmPassword = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    3, 180, 253, 0.76),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            padding:
                                                const EdgeInsets.all(16.0)),
                                        onPressed: () async {
                                          Navigator.pushReplacementNamed(
                                              context,
                                              RegisterSuccessScreen.routeName);
                                        },
                                        child: const Text(
                                          'Create Account',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway'),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      const Text(
                                        'Already have an account? ',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: const Text(
                                          'Login Here',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  10, 78, 178, 0.75)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
