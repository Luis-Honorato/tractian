import 'package:flutter_test/flutter_test.dart';
import 'package:tractian/node/domain/entities/asset_node.dart';
import 'package:tractian/node/domain/entities/location_node.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/node/domain/usecases/order_nodes_usecase.dart';

void main() {
  late final OrderNodesUsecase usecase;

  setUpAll(() {
    usecase = OrderNodesUsecase();
  });

  test('should order TreeNodes to a correct node hierarchy', () {
    final List<TreeNode> disorderedNodes = [
      LocationNode(
        id: 'Location A',
        name: 'Location A',
        parentId: null,
      ),
      AssetNode(
        id: 'Asset 1',
        name: 'Asset 1',
        locationId: 'Location A',
      ),
      AssetNode(
        id: 'Component A1',
        name: 'Component A1',
        sensorType: 'any',
        parentId: 'Asset 1',
      ),
      AssetNode(
        id: 'Component A2',
        name: 'Component A2',
        sensorType: 'any',
        parentId: 'Asset 1',
      ),
      AssetNode(
        id: 'Asset 2',
        name: 'Asset 2',
        locationId: 'Location A',
      ),
      AssetNode(
        id: 'Component B1',
        name: 'Component B1',
        sensorType: 'any',
        parentId: 'Asset 2',
      ),
      AssetNode(
        id: 'Component B2',
        name: 'Component B2',
        sensorType: 'any',
        parentId: 'Asset 2',
      ),
      LocationNode(
        id: 'Location B',
        name: 'Location B',
        parentId: null,
      ),
      LocationNode(
        id: 'Location C',
        name: 'Location C',
        locationId: 'Location B',
      ),
      AssetNode(
        id: 'Asset 3',
        name: 'Asset 3',
        locationId: 'Location C',
      ),
      AssetNode(
        id: 'Component C1',
        name: 'Component C1',
        sensorType: 'any',
        parentId: 'Asset 3',
      ),
      AssetNode(
        id: 'Component C2',
        name: 'Component C2',
        sensorType: 'any',
        parentId: 'Asset 3',
      ),
      AssetNode(
        id: 'Component D1',
        name: 'Component D1',
        sensorType: 'any',
        parentId: 'Location C',
      ),
      AssetNode(
        id: 'Component X',
        name: 'Component X',
        sensorType: 'any',
      ),
    ];

    final resultMap = usecase(disorderedNodes);

    /// Check if Location A is at the root level.
    expect(resultMap.containsKey('Location A'), isTrue);

    /// Check the Assets children of Location A.
    final locationA = resultMap['Location A']!;
    expect(locationA.children.containsKey('Asset 1'), isTrue);
    expect(locationA.children.containsKey('Asset 2'), isTrue);

    /// Check the components of Asset 1.
    final asset1 = locationA.children['Asset 1']!;
    expect(asset1.children.containsKey('Component A1'), isTrue);
    expect(asset1.children.containsKey('Component A2'), isTrue);

    /// Check the components of Asset 2.
    final asset2 = locationA.children['Asset 2']!;
    expect(asset2.children.containsKey('Component B1'), isTrue);
    expect(asset2.children.containsKey('Component B2'), isTrue);

    /// Check if Location B is at the root and contains Location C.
    expect(resultMap.containsKey('Location B'), isTrue);
    final locationB = resultMap['Location B']!;
    expect(locationB.children.containsKey('Location C'), isTrue);

    /// Check the children of Location C.
    final locationC = locationB.children['Location C']!;
    expect(locationC.children.containsKey('Asset 3'), isTrue);
    expect(locationC.children.containsKey('Component D1'), isTrue);

    /// Check the components of Asset 3.
    final asset3 = locationC.children['Asset 3']!;
    expect(asset3.children.containsKey('Component C1'), isTrue);
    expect(asset3.children.containsKey('Component C2'), isTrue);

    /// Check if Component X is at the root level, without children nodes.
    expect(resultMap.containsKey('Component X'), isTrue);
    expect(resultMap['Component X']!.children.isEmpty, isTrue);
  });

  test('Should order until layer 4', () {
    final List<TreeNode> disorderedNodes = [
      LocationNode(id: 'Location 1', name: 'Location 1', locationId: null),
      LocationNode(
          id: 'Location 2', name: 'Location 2', locationId: 'Location 1'),
      LocationNode(
          id: 'Location 3', name: 'Location 3', locationId: 'Location 2'),
      LocationNode(
          id: 'Location 4', name: 'Location 4', locationId: 'Location 3'),
    ];

    final resultMap = usecase(disorderedNodes);

    /// In root layer only shuld have one location
    expect(resultMap.length, equals(1));

    /// Location 1 must have only one child it must be Location 2
    final location1 = resultMap['Location 1'];
    expect(location1!.children.length, equals(1));
    expect(location1.children.containsKey('Location 2'), isTrue);

    /// Location 2 must have only one child it must be Location 3
    final location2 = location1.children['Location 2'];
    expect(location2!.children.length, equals(1));
    expect(location2.children.containsKey('Location 3'), isTrue);

    /// Location 3 must have only one child it must be Location 4
    final location3 = location2.children['Location 3'];
    expect(location3!.children.length, equals(1));
    expect(location3.children.containsKey('Location 4'), isTrue);
  });
}
