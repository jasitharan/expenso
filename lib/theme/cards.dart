import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'design_system.dart';

class ListCard extends StatelessWidget {
  final Function handler;
  final String title;
  final String subTitle;
  const ListCard(
      {Key? key,
      required this.handler,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: Insets.m),
        color: MyColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: () => handler(),
          child: SizedBox(
            width: mediaQuery.size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: Insets.xxl + 8, top: Insets.m, right: Insets.m),
                  child: SizedBox(
                    height: 30,
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: MyColors.lightDarkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Insets.xxl + 8,
                      top: Insets.xxs,
                      right: Insets.m,
                      bottom: Insets.m),
                  child: SizedBox(
                    height: 30,
                    child: AutoSizeText(
                      subTitle,
                      maxLines: 2,
                      minFontSize: 10,
                      style: const TextStyle(
                          color: MyColors.lightGray2, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class GridCard extends StatelessWidget {
  final String imageName;
  final Function handler;
  final String title;
  final String subTitle;
  final double? width;
  final double? height;

  const GridCard(
      {Key? key,
      required this.imageName,
      required this.handler,
      required this.title,
      this.height,
      this.width,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
        color: MyColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: () => handler(),
          child: SizedBox(
            width: width ?? mediaQuery.size.width * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox10,
                Image.asset(
                  imageName,
                  fit: BoxFit.contain,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: MyColors.lightDarkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subTitle,
                  style:
                      const TextStyle(color: MyColors.lightGray2, fontSize: 14),
                ),
                sizedBox20
              ],
            ),
          ),
        ));
  }
}
