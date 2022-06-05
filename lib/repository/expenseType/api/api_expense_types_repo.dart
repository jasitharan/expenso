import 'package:http/http.dart' as http;
import '../../env.dart';
import '../expense_type_repo.dart';

class ApiExpenseTypesRepo implements ExpenseTypeRepo {
  @override
  Future getAllExpenseTypes(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/expense_types'),
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
