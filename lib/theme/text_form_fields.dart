import 'package:flutter/material.dart';
import 'design_system.dart';

class ClassTextFormField extends StatefulWidget {
  final bool isPassword;
  final String imageName;
  final Function(String?) validator;
  final Function(String) onChanged;
  final String? hintText;
  const ClassTextFormField({
    Key? key,
    this.isPassword = false,
    this.hintText,
    required this.imageName,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  State<ClassTextFormField> createState() => _ClassTextFormFieldState();
}

class _ClassTextFormFieldState extends State<ClassTextFormField> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width * 0.75,
      child: TextFormField(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: Insets.m),
            child: Image.asset(
              widget.imageName,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          prefixIconColor: MyColors.darkGray,
          fillColor: MyColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: MyColors.midWhite1),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: (val) => widget.validator(val),
        onChanged: (val) => widget.onChanged(val),
      ),
    );
  }
}

class ClassicField extends StatefulWidget {
  final String suffixName;
  final Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  const ClassicField({
    Key? key,
    this.hintText,
    required this.suffixName,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<ClassicField> createState() => _ClassicFieldState();
}

class _ClassicFieldState extends State<ClassicField> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width * 0.75,
      height: 60,
      child: TextFormField(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          suffixIcon: Container(
            width: 100,
            child: Center(
                child: Text(
              widget.suffixName,
              style: const TextStyle(color: MyColors.midGold),
            )),
            decoration: const BoxDecoration(
              color: MyColors.darkBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                bottomRight: Radius.circular(32.0),
              ),
            ),
          ),
          fillColor: MyColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: MyColors.midWhite1),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: (val) =>
            widget.validator == null ? null : widget.validator!(val),
        onChanged: (val) =>
            widget.onChanged == null ? null : widget.onChanged!(val),
      ),
    );
  }
}
