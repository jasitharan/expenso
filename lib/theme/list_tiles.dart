import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/expense_provider.dart';
import '../providers/models/expense_model.dart';
import '../providers/models/user_model.dart';
import 'modal_bottom_sheets.dart';

class ExpenseTile extends StatefulWidget {
  final ExpenseModel expense;
  final Function? refresh;

  const ExpenseTile({
    Key? key,
    required this.expense,
    this.refresh,
  }) : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _expense = Provider.of<ExpenseProvider>(context, listen: false);

    Color color = Colors.green;
    String realStatus = widget.expense.status ?? '';

    if (widget.expense.status == 'Approved') {
      color = Colors.green;
    } else if (widget.expense.status == 'Rejected') {
      color = Colors.red;
    } else if (widget.expense.status == 'Unknown') {
      realStatus = 'Pending';
      color = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CachedNetworkImage(
            imageUrl: kBackendUrl + widget.expense.type.image,
            fit: BoxFit.cover,
            height: 30,
            width: 30,
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage('assets/images/check.png')),
          ),
          title: Text(
            widget.expense.title,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(widget.expense.type.name),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '- rs.${widget.expense.cost}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.expense.status != ''
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 72),
                    child: Text(
                      realStatus,
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  )
                : Container(),
            widget.expense.status != '' && widget.expense.status != 'Approved'
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  context: context,
                                  builder: (context) => ExpenseModalBottomSheet(
                                        expense: widget.expense,
                                        isEdit: true,
                                        refresh: widget.refresh,
                                      ));
                              widget.refresh!();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromRGBO(64, 142, 189, 1),
                            )),
                        IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to delete this expense'),
                                    actions: [
                                      // The "Yes" button
                                      TextButton(
                                          onPressed: () async {
                                            // Remove the box
                                            _expense.expenses
                                                .removeExpenseWithId(
                                                    widget.expense.id!);
                                            widget.refresh!();
                                            Navigator.of(context).pop();
                                            // Close the dialog
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'))
                                    ],
                                  );
                                },
                              ).then((value) async => {
                                    await _expense.deleteExpense(
                                        widget.expense.id!, _user.uid)
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )
                : Container()
          ],
        ),
        divider
      ],
    );
  }
}

// ignore: must_be_immutable
class SettingItemTile extends StatefulWidget {
  final String title;
  String value;
  final Function validator;
  final Function onChanged;
  final Function onTap;
  SettingItemTile({
    Key? key,
    required this.title,
    required this.validator,
    required this.onChanged,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  State<SettingItemTile> createState() => _SettingItemTileState();
}

class _SettingItemTileState extends State<SettingItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: TextFormField(
            onChanged: (val) => widget.onChanged(val),
            validator: (val) => widget.validator(val),
            initialValue: widget.value,
            onTap: () => widget.onTap(),
            style: const TextStyle(
                color: Color.fromRGBO(57, 98, 187, 1), fontSize: 18),
            decoration: const InputDecoration(
                border: InputBorder.none, focusedBorder: InputBorder.none),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
        const Divider(
          thickness: 1.0,
          color: Color.fromRGBO(14, 82, 182, 0.3),
        ),
      ],
    );
  }
}
