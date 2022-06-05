import 'package:expenso/screens/Auth/reset_password_screen.dart';
import 'package:expenso/screens/Auth/wrapper.dart';
import 'package:expenso/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot-password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKeyForForgot = GlobalKey<FormState>();

  String _email = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: _loading
            ? loading
            : Stack(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKeyForForgot,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 350,
                              ),
                              const Text(
                                'Forget Password ?',
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 32),
                                child: ClassTextFormField(
                                  imageName: kEmailIcon,
                                  hintText: 'Email',
                                  validator: (val) =>
                                      !isEmail(val!) ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    _email = val;
                                  },
                                ),
                              ),
                              ClassicButton(
                                title: 'Send reset link',
                                handler: () async {
                                  if (_formKeyForForgot.currentState!
                                      .validate()) {
                                    setState(() {
                                      _loading = true;
                                    });

                                    final result =
                                        await _auth.forgotPassword(_email);

                                    if (result == null) {
                                      showSnacBar(context,
                                          'Please provide valid information');
                                      setState(() {
                                        _loading = false;
                                      });
                                    } else if (result == 200) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        ResetPasswordScreen.routeName,
                                        arguments: {'email': _email},
                                      );
                                    } else {
                                      showSnacBar(
                                        context,
                                        'We can\'t find a user with that email address.',
                                      );
                                      setState(() {
                                        _loading = false;
                                      });
                                    }
                                  }
                                },
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
                              ClassicTextButton(
                                  leading: 'Back to',
                                  title: 'Sign In',
                                  fontSize: 20,
                                  handler: () {
                                    Navigator.pushReplacementNamed(
                                        context, Wrapper.routeName);
                                  }),
                            ],
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
