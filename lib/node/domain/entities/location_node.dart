import 'package:tractian/node/domain/entities/tree_node.dart';

/// [LocationNode] is a [TreeNode], displayed on [AssetsPage] in [TreeNodeWidget].
///
///
/// All children must have a [locationId] equals [id].
class LocationNode extends TreeNode {
  LocationNode({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    super.children,
  });

  @override
  LocationNode copyWith({
    String? id,
    String? name,
    Map<String, TreeNode>? children,
    String? parentId,
    String? locationId,
    bool? isOpen,
  }) {
    return LocationNode(
      id: id ?? this.id,
      name: name ?? this.name,
      children: children ?? this.children,
      parentId: parentId ?? this.parentId,
    );
  }
}
