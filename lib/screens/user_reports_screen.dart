import 'dart:io';

import 'package:csv/csv.dart';
import 'package:expenso/providers/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';
import '../providers/expense_provider.dart';
import '../providers/models/user_model.dart';

class UserReportsScreen extends StatefulWidget {
  const UserReportsScreen({Key? key}) : super(key: key);

  static const routeName = '/user-reports-screen';

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

getCsv(List<List> data) async {
  if (await Permission.storage.request().isGranted) {
    final path = await _localPath;
    File f = File('$path/mycsv.csv');
    String csv = const ListToCsvConverter().convert(data);
    await f.writeAsString(csv);
    Share.shareFiles(['$path/mycsv.csv'], text: '');
  } else {
    await [
      Permission.storage,
    ].request();
  }
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  int startMonth = 1;
  int endMonth = 12;
  bool _isInit = true;

  List<bool> yearCategory = List.filled(5, false);
  List<ExpenseModel>? list = [];

  List yearCategoriesList = [
    {'name': '1st QTR', 'start': 1, 'end': 3},
    {'name': '2nd QTR', 'start': 4, 'end': 6},
    {'name': '3rd QTR', 'start': 7, 'end': 9},
    {'name': '4th QTR', 'start': 10, 'end': 12},
    {'name': 'Yearly', 'start': 1, 'end': 12}
  ];

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      final _user = Provider.of<UserModel>(context, listen: false);
      final _expense = Provider.of<ExpenseProvider>(context, listen: false);

      list = await _expense.getExpenses(
        _user.uid,
        startDate: DateTime(DateTime.now().year, 01, 01),
        endDate: DateTime(DateTime.now().year, 12, 31),
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 57, 74, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 57, 74, 1),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sizedBox10,
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                'User Reports Export',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          sizedBox30,
          const Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16),
            child: Text(
              'Set encounter history range ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          sizedBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Begin',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // height: 200,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(209, 207, 215, 0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        DateFormat('MMMM').format(DateTime(0, startMonth)),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'End',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // height: 200,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(209, 207, 215, 0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        DateFormat('MMMM').format(DateTime(0, endMonth)),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15.0,
              runSpacing: 20.0,
              children: yearCategoriesList.map((e) {
                int index = yearCategoriesList.indexOf(e);
                return InkWell(
                  onTap: () {
                    yearCategory = List.filled(5, false);
                    yearCategory[index] = true;
                    startMonth = e['start'];
                    endMonth = e['end'];
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: yearCategory[index]
                          ? const Color.fromRGBO(48, 173, 209, 1.0)
                          : null,
                      border: Border.all(
                          color: const Color.fromRGBO(209, 207, 215, 0.5)),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      e['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          sizedBox50,
          sizedBox20,
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: mediaQuery.size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 16.0)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(48, 173, 209, 1.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ))),
                    onPressed: () async {
                      List<List<dynamic>> finalExpenseData =
                          List.empty(growable: true);
                      List<ExpenseModel> expenses = list!
                          .where((e) =>
                              e.createdDate.month <= endMonth &&
                              e.createdDate.month >= startMonth)
                          .toList();

                      // Headers
                      List<dynamic> row = List.empty(growable: true);
                      row.add('Expense For');
                      row.add('Expense Cost');
                      row.add('Created Date');
                      row.add('ExpenseType');

                      finalExpenseData.add(row);

                      // Fields
                      for (var i = 0; i < expenses.length; i++) {
                        List<dynamic> row = List.empty(growable: true);
                        row.add(expenses[i].title);
                        row.add(expenses[i].cost);
                        row.add(DateFormat.yMMMMd()
                            .format(expenses[i].createdDate));
                        row.add(expenses[i].type.name);

                        finalExpenseData.add(row);
                      }

                      await getCsv(finalExpenseData);
                    },
                    child: const Text(
                      'Export Now (CSV)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
