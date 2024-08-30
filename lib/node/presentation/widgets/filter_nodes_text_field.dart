import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/node/domain/filters/node_filters.dart';
import 'package:tractian/node/presentation/blocs/node/node_bloc.dart';
import 'package:tractian/theme/theme_colors.dart';
import 'package:tractian/utils/tractian_icons.dart';

class FilterNodesTextField extends StatefulWidget {
  const FilterNodesTextField({super.key});

  @override
  State<FilterNodesTextField> createState() => _FilterNodesTextFieldState();
}

class _FilterNodesTextFieldState extends State<FilterNodesTextField> {
  late final NodeBloc nodeBloc;
  @override
  void initState() {
    super.initState();
    nodeBloc = BlocProvider.of<NodeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.04,
      ),
      child: BlocBuilder<NodeBloc, NodeState>(
        bloc: nodeBloc,
        buildWhen: (previous, current) => previous.filters != current.filters,
        builder: (context, state) {
          return TextFormField(
            onChanged: (value) {
              nodeBloc.add(
                FilterNodesEvent(
                  filters: state.filters?.copyWith(query: value) ??
                      NodeFilters(
                        query: value,
                      ),
                ),
              );
            },
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: 'Buscar Ativo ou Local',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.only(top: 8),
              prefixIcon: const Icon(TractianIcons.search, size: 16),
              alignLabelWithHint: true,
              filled: true,
              fillColor: ThemeColors.backgroundGray,
            ),
          );
        },
      ),
    );
  }
}
