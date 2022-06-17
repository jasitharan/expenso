import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'theme/themes.dart';

const String kAppName = 'Expenso';
const String kBackgroundSvg = "assets/svgs/gettingStarted.svg";
const String kAuthBackgroundSvg = "assets/svgs/auth_background.svg";
const String kGettingStartedImage = 'assets/images/back_image.png';
const String kAuthBackgroundImage = "assets/images/login_background.png";
const String kGoogleIcon = 'assets/images/google.png';
const String kEmailIcon = 'assets/images/email2PrefixIcon.png';
const String kEmailIcon2 = 'assets/images/emailPrefixIcon.png';
const String kPasswordIcon = 'assets/images/password2PrefixIcon.png';
const String kPasswordIcon2 = 'assets/images/passwordPrefixIcon.png';
const String kUserIcon = 'assets/images/userPrefixIcon.png';
const String kPhoneIcon = 'assets/images/phonePrefixIcon.png';
const String kCheckIcon = 'assets/images/check.png';
const String kBackendUrl = 'http://192.168.8.175:8000';

const divider = Divider(
  color: MyColors.midGold,
  indent: 20,
  endIndent: 20,
  thickness: 0.75,
);

const loading = Center(
  child: SpinKitFadingCircle(
    color: MyColors.midGold,
    size: 50.0,
  ),
);

// SizedBoxes

const sizedBox10 = SizedBox(
  height: 10,
);

const sizedBox20 = SizedBox(
  height: 20,
);

const sizedBox25 = SizedBox(
  height: 25,
);

const sizedBox30 = SizedBox(
  height: 30,
);

const sizedBox40 = SizedBox(
  height: 40,
);

const sizedBox50 = SizedBox(
  height: 50,
);
