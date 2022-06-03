import 'package:expenso/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    return _loading
        ? loading
        : SafeArea(
            child: Container(
              color: const Color.fromRGBO(235, 241, 245, 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      minLeadingWidth: 10,
                      horizontalTitleGap: 10,
                      trailing: InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          await _auth.signOut();
                        },
                        child: const Image(
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bell.png'),
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: const Image(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/human.png'),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'John Doe',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(60, 90, 154, 1),
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Recomended actions for you',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'September 23, 2021',
                          style: TextStyle(
                              color: Color.fromRGBO(
                                3,
                                15,
                                40,
                                1,
                              ),
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(image: AssetImage('assets/images/calendar.png')),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Recent Spendings',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(249, 249, 249, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 28.0, top: 40, bottom: 8),
                            child: Text(
                              'Today',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ListView.builder(
                            itemCount: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Container(
                                  child: const Image(
                                      image:
                                          AssetImage('assets/images/home.png')),
                                ),
                                title: const Text('Nike Store'),
                                subtitle: const Text('Clothing'),
                                trailing: const Text(
                                  '- ₹1782.00',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
