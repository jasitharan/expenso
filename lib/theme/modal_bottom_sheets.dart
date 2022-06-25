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
import 'themes.dart';

class ExpenseModalBottomSheet extends StatefulWidget {
  final bool isEdit;
  final ExpenseModel? expense;
  final Function? refresh;
  const ExpenseModalBottomSheet({
    Key? key,
    this.isEdit = false,
    this.expense,
    this.refresh,
  }) : super(key: key);

  @override
  State<ExpenseModalBottomSheet> createState() =>
      _ExpenseModalBottomSheetState();
}

class _ExpenseModalBottomSheetState extends State<ExpenseModalBottomSheet> {
  DateTime? selectedDate;
  bool isScaned = false;
  String? expFor;
  double? expenseCost;
  ExpenseTypeModel? expenseType;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      selectedDate = widget.expense!.createdDate;
      expenseCost = widget.expense!.cost;
      expFor = widget.expense?.title;
      expenseType = widget.expense?.type;
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

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: SizedBox(
          height: mediaQuery.size.height * 0.6,
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
                  mainAxisSize: MainAxisSize.min,
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
                              'Choose Types',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: expenseType?.name,
                            items: _expenseTypes.expenseTypes!
                                .map((ExpenseTypeModel value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(
                                  value.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                ExpenseTypeModel typeModel =
                                    _expenseTypes.expenseTypes!.firstWhere(
                                        (element) => element.name == val);

                                expenseType = typeModel;
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]"))
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
                  // SizedBox(
                  //   width: 100,
                  //   child: ClassicStylishButton(
                  //     title: isScaned ? 'Rescan' : 'Scan',
                  //     isClicked: true,
                  //     handler: () {
                  //       setState(() {
                  //         isScaned = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: 100,
                    child: ClassicStylishButton(
                      title: 'Save',
                      handler: () async {
                        if (selectedDate != null &&
                            expenseCost != null &&
                            expFor != null &&
                            expenseType != null) {
                          if (widget.isEdit) {
                            ExpenseModel expense = ExpenseModel(
                              id: widget.expense!.id,
                              createdDate: selectedDate!,
                              cost: expenseCost!,
                              title: expFor!,
                              type: expenseType!,
                              status: widget.expense?.status,
                            );
                            _expense.expenses.editExpense(expense);
                            widget.refresh!();
                            await _expense.editExpense(
                              expense,
                              _user.uid,
                            );
                            showSnacBar(context, 'Successfully Created');
                          } else {
                            ExpenseModel expense = ExpenseModel(
                              createdDate: selectedDate!,
                              cost: expenseCost!,
                              title: expFor!,
                              status: 'Unknown',
                              type: expenseType!,
                            );
                            _expense.expenses.addExpense(expense);
                            await _expense.createExpense(
                              expense,
                              _user.uid,
                            );
                            showSnacBarFromTop(context, 'Successfully Updated');
                          }
                          Navigator.pop(
                            context,
                          );
                        } else {
                          showSnacBarFromTop(
                              context, 'Please provide valid information');
                        }
                      },
                    ),
                  ),
                ],
              ),
              sizedBox30
            ],
          ),
        ),
      ),
    );
  }
}
