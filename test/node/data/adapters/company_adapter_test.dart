import 'package:flutter_test/flutter_test.dart';
import 'package:tractian/node/data/adapters/company_adapter.dart';

import '../../node_utils/node_utils.dart';

void main() {
  test('Should return a list of Company', () {
    final companiesList =
        CompanyAdapter.fromJson(NodeUtilsTest.companiesJsonList);

    const expectedList = NodeUtilsTest.fakeCompaniesList;

    /// Check if Frist index is same
    expect(companiesList[0].id, equals(expectedList[0].id));

    /// Check if Last index is same
    expect(companiesList.last.id, equals(expectedList.last.id));
  });
}
