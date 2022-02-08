import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String iconName;
  final String hintText;
  final Function validator;
  final Color color;
  final bool isPassword;
  final Function onChanged;
  final String initialValue;

  const InputTextField(
      {Key? key,
      required this.iconName,
      required this.hintText,
      required this.initialValue,
      required this.validator(val),
      required this.onChanged(val),
      this.isPassword = false,
      this.color = Colors.black})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
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
      obscureText: widget.isPassword,
      initialValue: widget.initialValue,
      onChanged: (value) => widget.onChanged(value),
      validator: (val) => widget.validator(val),
      focusNode: myFocusNode,
      style:
          TextStyle(color: myFocusNode.hasFocus ? Colors.orange : Colors.grey),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(50.0),
          ),
          isDense: true,
          focusColor: Colors.orange,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image(
                height: 15,
                width: 15,
                color: myFocusNode.hasFocus ? Colors.orange : widget.color,
                image: AssetImage(widget.iconName)),
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: const TextStyle(color: Color.fromRGBO(189, 189, 189, 1))),
    );
  }
}
