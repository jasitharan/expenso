import 'dart:convert';

import 'package:expenso/repository/expense/expense_repo.dart';
import 'package:http/http.dart' as http;
import '../../env.dart';

class ApiExpenseRepo implements ExpenseRepo {
  @override
  Future createExpense(String expenseFor, int expenseTypeId, double expenseCost,
      DateTime createdDate, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$kApiUrl/expenses'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'expenseFor': expenseFor,
          'expenseType_id': expenseTypeId,
          'expenseCost': expenseCost,
          'createdDate': createdDate.toString(),
        }),
      );
      if (response.statusCode == 201) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future editExpense(int id, String expenseFor, int expenseTypeId,
      double expenseCost, DateTime createdDate, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$kApiUrl/expenses/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'expenseFor': expenseFor,
          'expenseType_id': expenseTypeId,
          'expenseCost': expenseCost,
          'createdDate': createdDate.toString(),
        }),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future getAllExpense(String token, String query) async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/expenses?$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future getExpense(int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/expenses/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future deleteExpense(int id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$kApiUrl/expenses/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future getStats(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/chartData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
