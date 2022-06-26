import 'package:http/http.dart' as http;
import '../../env.dart';
import '../companies_repo.dart';

class ApiCompaniesRepo implements CompaniesRepo {
  @override
  Future getAllCompanies() async {
    try {
      final response = await http.get(
        Uri.parse('$kApiUrl/companies'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
