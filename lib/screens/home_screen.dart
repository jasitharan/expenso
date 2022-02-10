import 'package:expenso/screens/page/dashboard_screen.dart';
import 'package:flutter/material.dart';

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
    const DashBoardScreen(),
    const DashBoardScreen(),
    const DashBoardScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoardScreen();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                        currentScreen = const DashBoardScreen();
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
                        currentScreen = const DashBoardScreen();
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
                        currentScreen = const DashBoardScreen();
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
