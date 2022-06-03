// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'design_system.dart';

import '../constants.dart';

class YesOrNoSelection extends StatefulWidget {
  String groupValue;
  final List<String> initialValue;
  final Function(String?) handler;
  final String title;
  final String? subtitle;

  YesOrNoSelection(
      {Key? key,
      this.subtitle,
      required this.groupValue,
      required this.initialValue,
      required this.title,
      required this.handler})
      : super(key: key);

  @override
  State<YesOrNoSelection> createState() => _YesOrNoSelectionState();
}

class _YesOrNoSelectionState extends State<YesOrNoSelection> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: widget.subtitle != null ? Insets.xxs - 2 : Insets.xs,
                left: Insets.xl),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: MyColors.midGold,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          if (widget.subtitle != null)
            Padding(
              padding:
                  const EdgeInsets.only(bottom: Insets.xs, left: Insets.xl),
              child: Text(
                widget.subtitle!,
                style: const TextStyle(
                  color: MyColors.midGold,
                  fontSize: 16,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: Insets.m),
                child: RadioButton(
                  fittedBox: false,
                  groupValue: widget.groupValue,
                  initialValue: widget.initialValue[0],
                  handler: (val) => widget.handler(val),
                  trailingValue: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: Insets.l),
                child: RadioButton(
                  fittedBox: false,
                  groupValue: widget.groupValue,
                  initialValue: widget.initialValue[1],
                  handler: (val) => widget.handler(val),
                  trailingValue: '',
                ),
              )
            ],
          ),
          divider
        ],
      ),
    );
  }
}

class TableSelection extends StatefulWidget {
  final bool horizontal;
  final List<Map<String, String>> initialValues;
  String groupValue;
  final Function(Map<String, String>) handler;
  final String title;
  final String? subTitle;
  final double size;

  TableSelection(
      {Key? key,
      this.horizontal = false,
      required this.handler,
      required this.title,
      this.subTitle,
      required this.size,
      required this.initialValues,
      required this.groupValue})
      : super(key: key);

  @override
  State<TableSelection> createState() => _TableSelectionState();
}

class _TableSelectionState extends State<TableSelection> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70,
            width: widget.size,
            padding: const EdgeInsets.all(Insets.s),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16,
                  child: AutoSizeText(
                    widget.title,
                    minFontSize: 12,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(color: MyColors.midGold, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                if (widget.subTitle != null)
                  SizedBox(
                    height: 18,
                    child: AutoSizeText(
                      widget.subTitle!,
                      minFontSize: 8,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          color: MyColors.midGold,
                          fontSize: 12),
                    ),
                  ),
                if (widget.subTitle != null)
                  const SizedBox(
                    height: 2,
                  ),
              ],
            ),
            decoration: const BoxDecoration(
              color: MyColors.darkBlue,
            ),
          ),
          Container(
            color: Colors.white,
            width: widget.size,
            padding: const EdgeInsets.symmetric(vertical: Insets.m),
            child: widget.horizontal
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: widget.initialValues
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Insets.m),
                                child: RadioButton(
                                  fittedBox: false,
                                  groupValue: widget.groupValue,
                                  radioColor: MyColors.darkBlue,
                                  textColor: MyColors.black,
                                  initialValue:
                                      '${e['value']!} ${e['trailing']}',
                                  handler: (val) {
                                    setState(() {
                                      widget.groupValue =
                                          '${e['value']!} ${e['trailing']}';
                                    });
                                    widget.handler(e);
                                  },
                                  trailingValue: '',
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.initialValues
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: Insets.s),
                              child: RadioButton(
                                  width: widget.size * 0.9,
                                  trailingValue: e['trailing']!,
                                  groupValue: widget.groupValue,
                                  radioColor: MyColors.darkBlue,
                                  textColor: MyColors.black,
                                  initialValue: e['value']!,
                                  handler: (val) => widget.handler(e)),
                            ))
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String groupValue;
  final String initialValue;
  final Function(String?) handler;
  final String trailingValue;
  final Color radioColor;
  final Color textColor;
  final bool fittedBox;
  final double? width;

  const RadioButton(
      {Key? key,
      required this.groupValue,
      this.radioColor = MyColors.white,
      this.textColor = MyColors.white,
      this.fittedBox = true,
      this.width,
      required this.trailingValue,
      required this.initialValue,
      required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: width == null ? width : width! * 0.2,
                  child: Radio<String>(
                    value: initialValue,
                    fillColor: MaterialStateProperty.all(radioColor),
                    groupValue: groupValue,
                    onChanged: (value) => handler(value),
                  ),
                ),
              ),
              if (width == null)
                const SizedBox(
                  width: 5,
                ),
              SizedBox(
                width: width == null ? width : width! * 0.40,
                child: AutoSizeText(
                  initialValue,
                  minFontSize: 8,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
              ),
            ],
          ),
          trailingValue != ''
              ? Padding(
                  padding: const EdgeInsets.only(right: Insets.xs),
                  child: SizedBox(
                    width: width == null ? width : width! * 0.2,
                    child: AutoSizeText(
                      trailingValue,
                      minFontSize: 16,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style:
                          const TextStyle(color: MyColors.black, fontSize: 18),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
