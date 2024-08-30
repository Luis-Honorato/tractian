import 'package:flutter_test/flutter_test.dart';

import 'package:tractian/node/data/adapters/asset_node_adapter.dart';

import '../../node_utils/node_utils.dart';

void main() {
  test('Should return a list of AssetNode', () {
    final assetsList = AssetNodeAdapter.fromJson(NodeUtilsTest.assetsJsonList);
    final expectedList = NodeUtilsTest.fakeAssetsList;

    /// Check if Frist index is same
    expect(assetsList[0].id, equals(expectedList[0].id));

    /// Check if Last index is same
    expect(assetsList.last.id, equals(expectedList.last.id));
  });
}
