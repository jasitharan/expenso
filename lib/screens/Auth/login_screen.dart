import 'package:expenso/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../theme/themes.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleAuth;
  const LoginScreen({Key? key, required this.toggleAuth}) : super(key: key);

  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyForLogin = GlobalKey<FormState>();

  bool _loading = false;

  String _email = '';
  String _password = '';

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
                        height: 370,
                      ),
                      Form(
                          key: _formKeyForLogin,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
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
                                    _email = val;
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
                                    _password = val;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
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
                                          if (_formKeyForLogin.currentState!
                                              .validate()) {
                                            setState(() {
                                              _loading = true;
                                            });

                                            final result = await _auth.signIn(
                                                _email, _password);

                                            if (result == null) {
                                              showSnacBar(context,
                                                  'Please provide valid information');
                                              setState(() {
                                                _loading = false;
                                              });
                                            }
                                          }
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
                                sizedBox20,
                                ClassicTextButton(
                                    leading: 'Don’t have an account?',
                                    title: 'Sign up',
                                    handler: () => widget.toggleAuth()),
                                sizedBox50
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            )),
    );
  }
}
