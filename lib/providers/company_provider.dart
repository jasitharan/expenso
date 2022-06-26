import 'package:expenso/providers/models/company_model.dart';

import '../repository/company/api/api_companies_repo.dart';
import '../repository/company/companies_repo.dart';

class CompanyProvider {
  final CompaniesRepo _companiesRepo = ApiCompaniesRepo();

  List<CompanyModel>? companies = [];
  bool isDone = false;

  Future getCompanies() async {
    dynamic result = await _companiesRepo.getAllCompanies();
    List<CompanyModel>? data;
    if (result != null) {
      data = companiesFromJson(result);
      companies = data;
    }
    return data;
  }
}
