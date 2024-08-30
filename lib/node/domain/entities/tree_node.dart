/// [TreeNode] is the main entity in app.
/// Could be a [AssetNode] or [LocationNode].
abstract class TreeNode {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final Map<String, dynamic> children;

  const TreeNode({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.children = const {},
  });

  TreeNode copyWith({
    String? id,
    String? name,
    String? parentId,
    String? locationId,
    Map<String, TreeNode>? children,
  });
}
