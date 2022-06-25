import 'package:flutter/material.dart';

class ClassTextFormField extends StatefulWidget {
  final bool isPassword;
  final String? imageName;
  final Function(String?) validator;
  final Function(String) onChanged;
  final String? hintText;
  final bool filled;
  final String? initialValue;
  const ClassTextFormField(
      {Key? key,
      this.isPassword = false,
      this.hintText,
      this.imageName,
      required this.onChanged,
      required this.validator,
      this.filled = false,
      this.initialValue})
      : super(key: key);

  @override
  State<ClassTextFormField> createState() => _ClassTextFormFieldState();
}

class _ClassTextFormFieldState extends State<ClassTextFormField> {
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    myFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.black),
      initialValue: widget.initialValue,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
          fillColor: Colors.white60,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(50.0),
          ),
          isDense: true,
          focusColor: Colors.orange,
          prefixIcon: widget.imageName == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Image(
                      height: 15,
                      width: 15,
                      color: myFocusNode.hasFocus
                          ? Colors.orange
                          : Colors.grey[700],
                      image: AssetImage(widget.imageName!)),
                ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: const TextStyle(color: Color.fromRGBO(189, 189, 189, 1))),
      validator: (val) => widget.validator(val),
      onChanged: (val) => widget.onChanged(val),
    );
  }
}
