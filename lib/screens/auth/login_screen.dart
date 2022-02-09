import 'package:expenso/screens/auth/forgot_password_screen.dart';
import 'package:expenso/screens/auth/register_screen.dart';
import 'package:expenso/shared/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_background.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 350,
                      ),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                InputTextField(
                                  iconName:
                                      'assets/images/email2PrefixIcon.png',
                                  hintText: 'Email',
                                  initialValue: email,
                                  color: Colors.grey,
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
                                  initialValue: password,
                                  iconName:
                                      'assets/images/password2PrefixIcon.png',
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
                                const SizedBox(
                                  height: 30,
                                ),
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
                                        onPressed: () async {},
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
                                const SizedBox(
                                  height: 50,
                                ),
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
                                  height: 30,
                                ),
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
                                          Image(
                                              image: AssetImage(
                                                  'assets/images/google.png')),
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
                                const SizedBox(
                                  height: 30,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const Text(
                                      'Don’t have an account? ',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, RegisterScreen.routeName);
                                      },
                                      child: const Text(
                                        'Sign up',
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
              ),
            ),
    );
  }
}
