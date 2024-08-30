part of 'node_bloc.dart';

sealed class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object> get props => [];
}

/// Called when user open a [Company] and must see its [TreeNodes]
class FetchNodesEvent extends NodeEvent {
  final String companyId;

  const FetchNodesEvent({required this.companyId});
}

/// Called when user types something in [FilterNodesTextField] or press
/// any [FilterButton]
class FilterNodesEvent extends NodeEvent {
  final NodeFilters filters;

  const FilterNodesEvent({
    required this.filters,
  });
}
