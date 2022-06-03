import 'dart:io';

import 'package:expenso/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKeyForRegister = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _name = '';
  String _phoneNumber = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
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
                            key: _formKeyForRegister,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 100.0,
                                  ),
                                  ClassTextFormField(
                                    imageName: kUserIcon,
                                    hintText: 'Name',
                                    validator: (val) {
                                      final temp =
                                          val.toString().split(' ').join();
                                      return !isAlpha(temp)
                                          ? 'Enter an name'
                                          : null;
                                    },
                                    onChanged: (val) {
                                      _name = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassTextFormField(
                                    imageName: kEmailIcon2,
                                    hintText: 'Email',
                                    validator: (val) => !isEmail(val!)
                                        ? 'Enter an email'
                                        : null,
                                    onChanged: (val) {
                                      _email = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassTextFormField(
                                    imageName: kPhoneIcon,
                                    hintText: 'Phone',
                                    validator: (val) => !isNumeric(val!)
                                        ? 'Enter an phone number'
                                        : null,
                                    onChanged: (val) {
                                      _phoneNumber = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassTextFormField(
                                    imageName: kPasswordIcon2,
                                    hintText: 'Password',
                                    isPassword: true,
                                    validator: (val) => val!.length < 8
                                        ? 'Password min 8 characters'
                                        : null,
                                    onChanged: (val) {
                                      _password = val;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassTextFormField(
                                    imageName: kPasswordIcon2,
                                    hintText: 'Confirm Password',
                                    isPassword: true,
                                    validator: (val) {
                                      return _password == val
                                          ? null
                                          : 'Passwords not match';
                                    },
                                    onChanged: (val) {},
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
                                          if (_formKeyForRegister.currentState!
                                              .validate()) {
                                            setState(() {
                                              _loading = true;
                                            });

                                            final result = await _auth.register(
                                              _email,
                                              _password,
                                              _name,
                                              _phoneNumber,
                                            );

                                            if (result == null) {
                                              showSnacBar(context,
                                                  'Please provide valid information');
                                              setState(() {
                                                _loading = false;
                                              });
                                            } else if (Platform.isIOS) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                '/',
                                                (Route<dynamic> route) => false,
                                              );
                                            }
                                          }
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
                                  ClassicTextButton(
                                    leading: 'Already have an account?',
                                    title: 'Login Here',
                                    handler: () {
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.routeName);
                                    },
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
