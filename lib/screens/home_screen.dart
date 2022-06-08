import 'package:expenso/constants.dart';
import 'package:expenso/providers/expense_type_provider.dart';
import 'package:expenso/providers/models/expense_type_model.dart';
import 'package:expenso/screens/home_pages/expenses_screen.dart';
import 'package:expenso/theme/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../providers/models/expense_model.dart';
import '../providers/models/user_model.dart';
import 'home_pages/dashboard_screen.dart';
import 'home_pages/expense_types_screen.dart';
import 'home_pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  final List<Widget> screens = [
    const DashBoardScreen(),
    const ProfileScreen(),
    const DashBoardScreen(),
    const DashBoardScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoardScreen();

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _expense = Provider.of<ExpenseProvider>(context, listen: false);
    final _expenseTypes =
        Provider.of<ExpenseTypeProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              builder: (context) {
                bool isScaned = false;
                return StatefulBuilder(
                  builder: (context, setState) => SizedBox(
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
                            const Text(
                              'Add New Expense',
                              style: TextStyle(
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
                            children: [
                              DropdownButton<String>(
                                items: _expenseTypes.expenseTypes!
                                    .map((ExpenseTypeModel value) {
                                  return DropdownMenuItem<String>(
                                    value: value.expType,
                                    child: Text(value.expType),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              )
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
                                  await _expense.createExpense(
                                    ExpenseModel(
                                      createdDate: DateTime.now(),
                                      expenseCost: 120,
                                      expenseTypeId: 2,
                                      expenseFor: 'Fort',
                                    ),
                                    _user.uid,
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        sizedBox30
                      ],
                    ),
                  ),
                );
              });
        },
        child: Image.asset('assets/images/plus.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const DashBoardScreen();
                          currentTab = 0;
                        });
                      },
                      minWidth: (mediaQuery.size.width / 5),
                      child: Image.asset('assets/images/home.png',
                          color: currentTab == 0 ? Colors.blue : Colors.black)),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const ExpenseTypesScreen();
                        currentTab = 1;
                      });
                    },
                    minWidth: (mediaQuery.size.width / 5),
                    child: Image.asset('assets/images/credit-card.png',
                        color: currentTab == 1 ? Colors.blue : Colors.black),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const ExpensesScreen();
                        currentTab = 2;
                      });
                    },
                    minWidth: (mediaQuery.size.width / 5),
                    child: Image.asset('assets/images/pie-chart.png',
                        color: currentTab == 2 ? Colors.blue : Colors.black),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();
                        currentTab = 3;
                      });
                    },
                    minWidth: (mediaQuery.size.width / 5),
                    child: Image.asset('assets/images/user.png',
                        color: currentTab == 3 ? Colors.blue : Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
