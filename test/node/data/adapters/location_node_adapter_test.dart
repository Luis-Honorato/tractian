import 'package:flutter_test/flutter_test.dart';
import 'package:tractian/node/data/adapters/location_node_adapter.dart';

import '../../node_utils/node_utils.dart';

void main() {
  test('Should return a list of LocationNode', () {
    final locationsList =
        LocationNodeAdapter.fromJson(NodeUtilsTest.jsonLocationsList);
    final expectedList = NodeUtilsTest.fakeLocationsList;

    /// Check if Frist index is same
    expect(locationsList[0].id, equals(expectedList[0].id));

    /// Check if Last index is same
    expect(locationsList.last.id, equals(expectedList.last.id));
  });
}
