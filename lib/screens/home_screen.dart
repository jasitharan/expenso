import 'package:expenso/screens/home_pages/expenses_screen.dart';
import 'package:expenso/theme/modal_bottom_sheets.dart';
import 'package:flutter/material.dart';

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

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoardScreen();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) => const ExpenseModalBottomSheet());

          if (currentTab == 2) {
            setState(() {
              currentScreen = ExpensesScreen(
                key: UniqueKey(),
              );
            });
          }
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
                    child: Image.asset('assets/images/expenseTypes.png',
                        width: 24,
                        height: 25,
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
                        currentScreen = ExpensesScreen(
                          key: UniqueKey(),
                        );
                        currentTab = 2;
                      });
                    },
                    minWidth: (mediaQuery.size.width / 5),
                    child: Image.asset('assets/images/expense.png',
                        height: 30,
                        width: 30,
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
