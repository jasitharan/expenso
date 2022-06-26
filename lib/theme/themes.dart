export 'buttons.dart';
export 'design_system.dart';
export 'cards.dart';
export 'text_form_fields.dart';
export 'snacbars.dart';
export 'charts.dart';
export 'custom_scroll.dart';
export 'list_tiles.dart';
export 'validators.dart';
export 'dialogs.dart';
import 'package:flutter/material.dart';
import 'design_system.dart';

class Themes {
  static final theme = ThemeData.light().copyWith(
    primaryColor: MyColors.darkBlue,
    backgroundColor: MyColors.lightDarkBlue,
    iconTheme: ThemeData.dark().iconTheme.copyWith(color: MyColors.darkGray),
    textTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: const TextStyle(color: Colors.black, fontSize: 18),
        bodyText2: const TextStyle(color: Colors.black, fontSize: 16),
        caption: const TextStyle(color: Colors.black, fontSize: 17),
        headline1: const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        headline2: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        headline3: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headline4: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        headline6: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        button: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
    appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.midDarkBlue,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: MyColors.white, fontSize: 24, fontWeight: FontWeight.bold)),
  );
}
