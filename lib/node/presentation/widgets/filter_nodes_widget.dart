import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/node/domain/filters/node_filters.dart';
import 'package:tractian/node/presentation/blocs/node/node_bloc.dart';
import 'package:tractian/node/presentation/widgets/filter_button.dart';
import 'package:tractian/utils/tractian_icons.dart';

class FilterNodesWidget extends StatefulWidget {
  const FilterNodesWidget({super.key});

  @override
  State<FilterNodesWidget> createState() => _FilterNodesWidgetState();
}

class _FilterNodesWidgetState extends State<FilterNodesWidget> {
  late final NodeBloc nodeBloc;
  @override
  void initState() {
    super.initState();
    nodeBloc = BlocProvider.of<NodeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(
      bloc: nodeBloc,
      buildWhen: (previous, current) => previous.filters != current.filters,
      builder: (context, state) {
        final bool filterByEnergySensor =
            state.filters?.filterByEnergySensor ?? false;
        final bool filterByAlert = state.filters?.filterByAlert ?? false;
        return Row(
          children: [
            FilterButton(
              label: 'Sensor de Energia',
              icon: TractianIcons.sensor,
              isSelected: filterByEnergySensor,
              onTap: () => nodeBloc.add(
                FilterNodesEvent(
                  filters: state.filters?.copyWith(
                          filterByEnergySensor: !filterByEnergySensor) ??
                      NodeFilters(
                        filterByEnergySensor: true,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            FilterButton(
              label: 'Crítico',
              icon: TractianIcons.exclamation,
              isSelected: filterByAlert,
              onTap: () => nodeBloc.add(
                FilterNodesEvent(
                  filters:
                      state.filters?.copyWith(filterByAlert: !filterByAlert) ??
                          NodeFilters(
                            filterByAlert: true,
                          ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
