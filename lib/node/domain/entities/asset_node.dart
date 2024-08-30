import 'package:tractian/node/domain/entities/tree_node.dart';

/// [AssetNode] is a [TreeNode], displayed on [AssetsPage] in [TreeNodeWidget].
///
/// Could be a component or asset, it is based on [isComponent], if a [AssetNode]
/// have [sensorType] it is a component.
///
/// All children must have a [parentId] equals [id].
class AssetNode extends TreeNode {
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;

  /// bool flag to indicate when is a component or asset
  final bool isComponent;
  AssetNode({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    super.children,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
  }) : isComponent = sensorType != null;

  @override
  AssetNode copyWith({
    String? id,
    String? name,
    Map<String, TreeNode>? children,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
    String? gatewayId,
    String? locationId,
  }) {
    return AssetNode(
      id: id ?? this.id,
      name: name ?? this.name,
      children: children ?? this.children,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      gatewayId: gatewayId ?? this.gatewayId,
      locationId: locationId ?? this.locationId,
    );
  }
}
