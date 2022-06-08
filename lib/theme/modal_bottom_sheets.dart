import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/expense_provider.dart';
import '../providers/expense_type_provider.dart';
import '../providers/models/expense_model.dart';
import '../providers/models/expense_type_model.dart';
import '../providers/models/user_model.dart';
import 'buttons.dart';

class ExpenseModalBottomSheet extends StatefulWidget {
  final bool isEdit;
  final ExpenseModel? expense;
  const ExpenseModalBottomSheet({
    Key? key,
    this.isEdit = false,
    this.expense,
  }) : super(key: key);

  @override
  State<ExpenseModalBottomSheet> createState() =>
      _ExpenseModalBottomSheetState();
}

class _ExpenseModalBottomSheetState extends State<ExpenseModalBottomSheet> {
  String? expTypeName;
  String? expFor;
  int? expTypeId;
  DateTime? selectedDate;
  bool isScaned = false;
  double? expenseCost;
  String? expenseTypeImage;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      expTypeName = widget.expense?.expenseTypeName;
      expTypeId = widget.expense?.expenseTypeId;
      selectedDate = widget.expense!.createdDate;
      expenseCost = widget.expense!.expenseCost;
      expFor = widget.expense?.expenseFor;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _expense = Provider.of<ExpenseProvider>(context, listen: false);
    final _expenseTypes =
        Provider.of<ExpenseTypeProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 38,
                width: 38,
              ),
              Text(
                widget.isEdit ? 'Edit Expense' : 'Add New Expense',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/close.png',
                    height: 38,
                    width: 38,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: const Text(
                        'Expense Type',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Choose Category',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: expTypeName,
                        items: _expenseTypes.expenseTypes!
                            .map((ExpenseTypeModel value) {
                          return DropdownMenuItem<String>(
                            value: value.expType,
                            child: Text(
                              value.expType,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            ExpenseTypeModel typeModel = _expenseTypes
                                .expenseTypes!
                                .firstWhere((element) =>
                                    element.expType == expTypeName);
                            expTypeName = val!;
                            expTypeId = typeModel.id;
                            expenseTypeImage = typeModel.expTypeImage;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                sizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: const Text(
                        'Date of Spend',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.35,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      )),
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            selectedDate == null
                                ? 'Select date '
                                : DateFormat('dd/MM/yyyy')
                                    .format(selectedDate!),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                sizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: const Text(
                        'Expense For',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: TextFormField(
                        initialValue: expFor,
                        onChanged: (val) {
                          expFor = val;
                        },
                      ),
                    )
                  ],
                ),
                sizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: const Text(
                        'Expense Cost',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.35,
                      child: TextFormField(
                        initialValue: expenseCost?.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                        ],
                        onChanged: (val) {
                          if (double.tryParse(val) != null) {
                            expenseCost = double.parse(val);
                          }
                        },
                      ),
                    )
                  ],
                ),
                sizedBox30
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: ClassicStylishButton(
                  title: isScaned ? 'Rescan' : 'Scan',
                  isClicked: true,
                  handler: () {
                    setState(() {
                      isScaned = true;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: ClassicStylishButton(
                  title: 'Save',
                  handler: () async {
                    if (selectedDate != null &&
                        expenseCost != null &&
                        expTypeId != null &&
                        expFor != null &&
                        expTypeName != null) {
                      if (widget.isEdit) {
                        await _expense.editExpense(
                          ExpenseModel(
                            id: widget.expense!.id,
                            createdDate: selectedDate!,
                            expenseCost: expenseCost!,
                            expenseTypeId: expTypeId!,
                            expenseFor: expFor!,
                            expenseTypeName: expTypeName!,
                          ),
                          _user.uid,
                        );
                      } else {
                        await _expense.createExpense(
                          ExpenseModel(
                            createdDate: selectedDate!,
                            expenseCost: expenseCost!,
                            expenseTypeId: expTypeId!,
                            expenseFor: expFor!,
                            expenseTypeName: expTypeName!,
                            expenseTypeImage: expenseTypeImage,
                            status: 'Unknown',
                          ),
                          _user.uid,
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
          sizedBox30
        ],
      ),
    );
  }
}
