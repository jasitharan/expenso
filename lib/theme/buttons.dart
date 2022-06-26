import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenso/providers/company_provider.dart';
import 'package:expenso/providers/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'design_system.dart';

class ClassicButton extends StatelessWidget {
  final String title;
  final Function handler;
  final double size;
  final Color? color;
  const ClassicButton({
    Key? key,
    required this.title,
    required this.handler,
    this.size = 200,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: ElevatedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: color == null
                  ? const Color.fromRGBO(3, 180, 253, 0.76)
                  : Colors.red,
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

// ignore: must_be_immutable
class ClassicStylishButton extends StatefulWidget {
  final String title;
  final Function handler;
  bool isClicked;
  final Color color;
  ClassicStylishButton({
    Key? key,
    this.color = Colors.white,
    required this.title,
    required this.handler,
    this.isClicked = false,
  }) : super(key: key);

  @override
  State<ClassicStylishButton> createState() => _ClassicStylishButtonState();
}

class _ClassicStylishButtonState extends State<ClassicStylishButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.isClicked
              ? const Color.fromRGBO(0, 146, 212, 1)
              : widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        onPressed: () => widget.handler(),
        child: Text(
          widget.title,
          style:
              TextStyle(color: widget.isClicked ? Colors.white : Colors.grey),
        ));
  }
}

// ignore: must_be_immutable
class ClassicDropdownButton extends StatefulWidget {
  final Function validator;
  final Function onChanged;
  CompanyModel? dropdownValue;
  ClassicDropdownButton({
    Key? key,
    required this.validator,
    required this.onChanged,
    required this.dropdownValue,
  }) : super(key: key);

  @override
  State<ClassicDropdownButton> createState() => _ClassicDropdownButtonState();
}

class _ClassicDropdownButtonState extends State<ClassicDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final company = Provider.of<CompanyProvider>(context, listen: false);

    return SizedBox(
      width: mediaQuery.size.width * 0.9,
      child: DropdownButtonFormField<String>(
        value: widget.dropdownValue != null ? widget.dropdownValue!.name : null,
        hint: const Text('Select Your Company', style: TextStyle(fontSize: 16)),
        icon: const Icon(
          Icons.arrow_downward,
          size: 20,
        ),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        style: const TextStyle(color: Colors.deepPurple),
        validator: (val) => widget.validator(val),
        onChanged: (val) => widget.onChanged(val),
        items: company.companies!
            .map((e) => e.name)
            .toList()
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}
