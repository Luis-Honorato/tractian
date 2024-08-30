part of 'node_bloc.dart';

class NodeState extends Equatable {
  final RequestStatus nodesStatus;
  final Map<String, dynamic> nodes;
  final Map<String, dynamic> filteredNodes;
  final NodeFilters? filters;
  const NodeState({
    this.nodesStatus = RequestStatus.initial,
    this.nodes = const {},
    this.filteredNodes = const {},
    this.filters,
  });

  NodeState copyWith({
    RequestStatus? nodesStatus,
    Map<String, dynamic>? nodes,
    Map<String, dynamic>? filteredNodes,
    NodeFilters? filters,
  }) {
    return NodeState(
      nodesStatus: nodesStatus ?? this.nodesStatus,
      nodes: nodes ?? this.nodes,
      filteredNodes: filteredNodes ?? this.filteredNodes,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [
        nodesStatus,
        nodes,
        filteredNodes,
        filters,
      ];
}
