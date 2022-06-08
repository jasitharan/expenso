import 'package:expenso/providers/expense_type_provider.dart';
import 'package:expenso/providers/models/expense_type_model.dart';
import 'package:expenso/theme/grid_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/models/user_model.dart';

class ExpenseTypesScreen extends StatefulWidget {
  const ExpenseTypesScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseTypesScreen> createState() => _ExpenseTypesScreenState();
}

class _ExpenseTypesScreenState extends State<ExpenseTypesScreen> {
  bool _loading = false;
  bool _isInit = true;
  List<ExpenseTypeModel> list = [];

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      final _user = Provider.of<UserModel>(context, listen: false);
      final _expenseTypes =
          Provider.of<ExpenseTypeProvider>(context, listen: false);

      if (!_expenseTypes.isDone) {
        await _expenseTypes.getExpenseTypes(_user.uid);
      }

      if (_expenseTypes.expenseTypes != null) {
        _expenseTypes.isDone = true;
        list = _expenseTypes.expenseTypes!;
      }

      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
      body: _loading
          ? loading
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox40,
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Expense Types',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  sizedBox50,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ExpenseTypeGridTile(
                        image: list[index].image,
                        title: list[index].name,
                        expTypeId: list[index].id,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
