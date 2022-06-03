import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'theme/themes.dart';

const String kAppName = "";
const String kBackgroundSvg = "assets/svgs/gettingStarted.svg";
const String kAuthBackgroundSvg = "assets/svgs/auth_background.svg";
const String kAppleIcon = "assets/icons/apple_icon.png";
const String kGoogleIcon = "assets/icons/google_icon.png";
const String kLiverIcon = "assets/icons/liver_icon.png";
const String kEmailIcon = "assets/icons/email_icon.png";
const String kUserIcon = "assets/icons/user_icon.png";
const String kPasswordIcon = "assets/icons/password_icon.png";
const String kGfrIcon = "assets/icons/gfr_icon.png";
const String kCrclIcon = "assets/icons/crcl_icon.png";
const String kSignInImage = "assets/images/signin_bottom_image.png";
const String kSignUpImage = "assets/images/signup_bottom_image.png";

const statusBarColor = SystemUiOverlayStyle(statusBarColor: MyColors.darkBlue);

const divider = Divider(
  color: MyColors.midGold,
  indent: 30,
  endIndent: 30,
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

const kCharToBEIgnored = 0xA0;
