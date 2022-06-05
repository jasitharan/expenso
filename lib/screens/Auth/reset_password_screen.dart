import 'package:expenso/screens/Auth/reset_password_success.dart';
import 'package:expenso/screens/Auth/wrapper.dart';
import 'package:expenso/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/reset-password-screen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKeyForReset = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _code = '';
  bool _loading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

      _email = routeArgs!['email']!;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKeyForReset,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 350,
                                width: mediaQuery.size.width,
                              ),
                              const Text(
                                'Reset Password',
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 32),
                                child: ClassTextFormField(
                                  imageName: kEmailIcon,
                                  hintText: 'Code',
                                  validator: (val) => val!.isEmpty
                                      ? 'Please enter a code'
                                      : null,
                                  onChanged: (val) {
                                    _code = val;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 32, bottom: 24),
                                child: ClassTextFormField(
                                  imageName: kPasswordIcon,
                                  hintText: 'Password',
                                  isPassword: true,
                                  validator: (val) => val!.length < 8
                                      ? 'Password min 8 characters'
                                      : null,
                                  onChanged: (val) {
                                    _password = val;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 32, bottom: 24),
                                child: ClassTextFormField(
                                  imageName: kPasswordIcon,
                                  hintText: 'Confirm Password',
                                  isPassword: true,
                                  validator: (val) {
                                    return _password == val
                                        ? null
                                        : 'Passwords not match';
                                  },
                                  onChanged: (val) {},
                                ),
                              ),
                              ClassicButton(
                                title: 'Update Password',
                                size: 300,
                                handler: () async {
                                  if (_formKeyForReset.currentState!
                                      .validate()) {
                                    setState(() {
                                      _loading = true;
                                    });

                                    final result = await _auth.resetPassword(
                                        _email, _code, _password);

                                    if (result == null) {
                                      showSnacBar(context,
                                          'Please provide valid information');
                                      setState(() {
                                        _loading = false;
                                      });
                                    } else if (result == 200) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        ResetPasswordSuccessScreen.routeName,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Back to',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, Wrapper.routeName);
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
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
                ],
              ),
            ),
    );
  }
}
