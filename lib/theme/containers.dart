import 'package:flutter/material.dart';

import '../constants.dart';
import 'buttons.dart';
import 'design_system.dart';

class HomeTopContainerWithBottomRadius extends StatelessWidget {
  const HomeTopContainerWithBottomRadius({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: mediaQuery.size.width * 0.1,
          ),
          Image.asset(
            kLiverIcon,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '(GFR. CRCL, keGFR, KFR)',
            style: TextStyle(color: MyColors.lightDarkBlue),
          ),
          const Text(
            'Calculator',
            style: TextStyle(color: MyColors.lightGold),
          ),
          const SizedBox(
            height: 10,
          ),
          ClassicTextButton(
            leading: 'Reference',
            title: 'Here',
            handler: () async {},
          ),
          SizedBox(
            height: mediaQuery.size.width * 0.1,
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
    );
  }
}

class ResultTopContainer extends StatelessWidget {
  final String? result;
  const ResultTopContainer({Key? key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      child: Column(
        children: [
          SizedBox(
            height: mediaQuery.size.width * 0.2,
          ),
          const Text(
            'Result',
            style: TextStyle(
                color: MyColors.lightDarkBlue,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          result != null
              ? Text(
                  result!,
                  style: const TextStyle(
                    color: MyColors.lightGold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  'Plaease fill  out the following requirements',
                  style: TextStyle(color: MyColors.lightGray1),
                ),
          SizedBox(
            height: mediaQuery.size.width * 0.3,
          )
        ],
      ),
      decoration: const BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
    );
  }
}
