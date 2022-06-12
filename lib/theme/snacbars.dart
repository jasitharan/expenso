import 'package:flutter/material.dart';

void showSnacBarFromTop(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 200, right: 20, left: 20),
  ));
}

void showSnacBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 2),
  ));
}
