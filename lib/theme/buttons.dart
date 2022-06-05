import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'design_system.dart';

class ClassicButton extends StatelessWidget {
  final String title;
  final Function handler;
  final double size;
  const ClassicButton(
      {Key? key, required this.title, required this.handler, this.size = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: ElevatedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(3, 180, 253, 0.76),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding: const EdgeInsets.all(16.0)),
          onPressed: () => handler(),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          )),
    );
  }
}

class ClassicOutlinedButton extends StatelessWidget {
  final String image;
  final String title;
  final Function handler;
  const ClassicOutlinedButton(
      {Key? key,
      required this.image,
      required this.title,
      required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width * 0.6,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: MyColors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              padding: const EdgeInsets.all(Insets.ms)),
          onPressed: () async => handler(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: Insets.xs, right: Insets.xxs),
                child: Image.asset(image),
              ),
              Expanded(
                child: AutoSizeText(
                  title,
                  minFontSize: 12,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: MyColors.midWhite1,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox()
            ],
          )),
    );
  }
}

class ClassicTextButton extends StatelessWidget {
  final String leading;
  final String title;
  final Function handler;
  final double fontSize;
  final Color titleColor;
  const ClassicTextButton({
    Key? key,
    required this.leading,
    required this.title,
    required this.handler,
    this.fontSize = 16,
    this.titleColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            leading,
            style: TextStyle(color: MyColors.midGray, fontSize: fontSize),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => handler(),
            child: Text(
              title,
              style: TextStyle(color: Colors.blue, fontSize: fontSize),
            ),
          )
        ],
      ),
    );
  }
}
