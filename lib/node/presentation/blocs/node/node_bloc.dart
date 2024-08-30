import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/web.dart';
import 'package:tractian/node/domain/entities/asset_node.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/node/domain/filters/node_filters.dart';
import 'package:tractian/node/domain/usecases/get_nodes_usecase.dart';
import 'package:tractian/node/domain/usecases/order_nodes_usecase.dart';
import 'package:tractian/utils/request_status.dart';

part 'node_event.dart';
part 'node_state.dart';

final _nodeLogger = Logger();

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  final GetNodesUsecase getNodesUsecase;
  final OrderNodesUsecase orderNodesUsecase;
  NodeBloc({
    required this.getNodesUsecase,
    required this.orderNodesUsecase,
  }) : super(NodeState()) {
    on<FetchNodesEvent>((event, emit) async {
      emit(state.copyWith(
        nodesStatus: RequestStatus.loading,
      ));

      final resultNodesList = await getNodesUsecase(event.companyId);

      final List<TreeNode> nodesList = resultNodesList.fold(
        (failure) {
          emit(state.copyWith(
            nodesStatus: RequestStatus.failure,
          ));
          _nodeLogger.w('Error while fetching Nodes');
          return [];
        },
        (nodes) {
          _nodeLogger.i('Success while fetching Nodes');
          return nodes;
        },
      );

      if (nodesList.isEmpty) return;

      try {
        final orderedNodes = orderNodesUsecase(nodesList);

        emit(state.copyWith(
          nodes: {...orderedNodes},
          filteredNodes: {...orderedNodes},
          nodesStatus: RequestStatus.success,
        ));
        _nodeLogger.i('Success while ordering Nodes');
      } catch (e) {
        emit(state.copyWith(
          nodesStatus: RequestStatus.failure,
        ));
        _nodeLogger.w('Error while ordering Nodes');
      }
    });

    on<FilterNodesEvent>((event, emit) {
      emit(state.copyWith(
        filters: event.filters,
      ));
      final filteredNodes = _filterNodes(
        state.nodes,
        query: state.filters?.query,
        filterByAlert: state.filters?.filterByAlert ?? false,
        filterByEnergySensor: state.filters?.filterByEnergySensor ?? false,
      );

      emit(state.copyWith(
        filteredNodes: {...filteredNodes},
      ));
    });
  }
  Map<String, dynamic> _filterNodes(
    Map<String, dynamic> nodes, {
    String? query,
    bool filterByAlert = false,
    bool filterByEnergySensor = false,
  }) {
    Map<String, TreeNode> filteredNodes = {};

    for (var entry in nodes.entries) {
      final node = entry.value;

      bool matchesQuery = query == null ||
          node.name.toLowerCase().contains(query.toLowerCase());

      bool matchesAlert =
          !filterByAlert || (node is AssetNode && node.status == 'alert');

      bool matchesEnergySensor = !filterByEnergySensor ||
          (node is AssetNode && node.sensorType == 'energy');

      bool matches = matchesQuery && matchesAlert && matchesEnergySensor;

      if (matches) {
        filteredNodes[entry.key] = node;
      } else if (node.children.isNotEmpty) {
        final filteredChildren = _filterNodes(
          node.children,
          query: query,
          filterByAlert: filterByAlert,
          filterByEnergySensor: filterByEnergySensor,
        );

        if (filteredChildren.isNotEmpty) {
          filteredNodes[entry.key] = node.copyWith(children: filteredChildren);
        }
      }
    }

    return filteredNodes;
  }
}
