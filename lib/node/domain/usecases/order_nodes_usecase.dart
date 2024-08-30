import 'package:tractian/node/domain/entities/tree_node.dart';

class OrderNodesUsecase {
  /// Order assets, nodes and components and returns
  /// a Map of [TreeNode] with id as key.
  Map<String, TreeNode> call(List<TreeNode> disorderedNodes) {
    /// Creates a Map to access nodes by id
    final Map<String, TreeNode> nodesMap = {
      for (final node in disorderedNodes) node.id: node
    };

    /// Map to store all ordered nodes
    final Map<String, TreeNode> rootNodes = {};

    for (final node in disorderedNodes) {
      if (node.parentId == null && node.locationId == null) {
        /// If node hasn't [parentId] or [locationId], must stay on root
        rootNodes[node.id] = node;
      } else if (node.locationId != null) {
        /// If node has a [locationId], allocate it to its location parent
        _addToParent(rootNodes, node.locationId!, node, nodesMap);
      } else if (node.parentId != null) {
        /// If node has a [parentId], allocate it to its asset parent
        _addToParent(rootNodes, node.parentId!, node, nodesMap);
      }
    }

    return rootNodes;
  }

  /// Function to recursively add a node to its parent in the tree
  void _addToParent(
    Map<String, TreeNode> rootNodes,
    String parentId,
    TreeNode childNode,
    Map<String, TreeNode> nodesMap,
  ) {
    /// First, try to add it to the root layer
    if (rootNodes.containsKey(parentId)) {
      final parentNode = rootNodes[parentId]!;
      rootNodes[parentId] = parentNode.copyWith(
        children: {...parentNode.children, childNode.id: childNode},
      );
    } else {
      /// If parent isn't found in the root layer,
      /// recursively search in all children
      for (final node in rootNodes.values) {
        final updatedNode = _addChildToNode(node, parentId, childNode);
        if (updatedNode != null) {
          rootNodes[node.id] = updatedNode;
          break;
        }
      }
    }
  }

  /// Recursively searches for the parent node and adds the child
  TreeNode? _addChildToNode(
    TreeNode currentNode,
    String parentId,
    TreeNode childNode,
  ) {
    if (currentNode.id == parentId) {
      return currentNode.copyWith(
        children: {...currentNode.children, childNode.id: childNode},
      );
    } else {
      for (final child in currentNode.children.values) {
        final updatedChild = _addChildToNode(child, parentId, childNode);
        if (updatedChild != null) {
          final updatedChildren =
              Map<String, TreeNode>.from(currentNode.children);
          updatedChildren[child.id] = updatedChild;
          return currentNode.copyWith(children: updatedChildren);
        }
      }
    }
    return null;
  }
}
