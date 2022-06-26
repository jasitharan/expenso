import 'package:expenso/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../theme/themes.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String _code = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  _loading = true;
                });
                await _auth.signOut();
              },
              child: const Text(
                'logout',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
      body: _loading
          ? loading
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Enter vertification code',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      sizedBox30,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClassTextFormField(
                          initialValue: _code,
                          hintText: 'Verification code',
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : "Please enter a verification code",
                          onChanged: (val) {
                            _code = val;
                          },
                        ),
                      ),
                      sizedBox30,
                      ClassicButton(
                        title: 'Submit',
                        size: 180,
                        handler: () {},
                      ),
                      sizedBox25,
                      ClassicButton(
                        title: 'Resend',
                        size: 180,
                        handler: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
