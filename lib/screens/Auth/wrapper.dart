import 'package:expenso/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/models/user_model.dart';
import '../home_screen.dart';
import 'auth_screen.dart';
import 'verify_email_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  static const routeName = '/wrapper';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      final companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
      await companyProvider.getCompanies();
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    // return either home or authenticate widget
    return user == null
        ? const AuthScreen()
        : (user.isVerified ? const HomeScreen() : const VerifyEmailScreen());
  }
}
