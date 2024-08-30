import 'package:tractian/node/domain/entities/company.dart';

class CompanyAdapter {
  CompanyAdapter._();

  /// Adaptate a json into [List<Company>]
  static List<Company> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map((company) => Company(
              id: company['id'],
              name: company['name'],
            ))
        .toList();
  }
}
