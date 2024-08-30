import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/node/domain/entities/asset_node.dart';
import 'package:tractian/node/domain/entities/location_node.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/node/presentation/blocs/node/cubit/node_is_open_cubit.dart';
import 'package:tractian/node/presentation/widgets/warning_widget.dart';
import 'package:tractian/theme/theme_colors.dart';
import 'package:tractian/utils/tractian_icons.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNode node;
  final int level;

  const TreeNodeWidget({
    super.key,
    required this.node,
    this.level = 0,
  });

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  late final NodeIsOpenCubit nodeIsOpenCubit;
  @override
  void initState() {
    super.initState();
    nodeIsOpenCubit = NodeIsOpenCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: nodeIsOpenCubit,
      child: BlocBuilder<NodeIsOpenCubit, bool>(
        builder: (context, isExpanded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: widget.level * 8.0),
                child: InkWell(
                  enableFeedback: widget.node.children.isNotEmpty,
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.node.children.isNotEmpty,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: const Icon(TractianIcons.arrow_down),
                      ),
                      Icon(
                        widget.node is LocationNode
                            ? TractianIcons.location
                            : (widget.node as AssetNode).isComponent
                                ? TractianIcons.component
                                : TractianIcons.asset,
                        color: ThemeColors.bluePrimary,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.node.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 5),
                      if (widget.node is AssetNode &&
                          (widget.node as AssetNode).sensorType ==
                              'energy') ...[
                        const Icon(
                          TractianIcons.sensor_filled,
                          size: 16,
                          color: ThemeColors.green,
                        ),
                        const SizedBox(width: 5),
                      ],
                      WarningWidget(
                        showWarning: widget.node is AssetNode &&
                            (widget.node as AssetNode).status == 'alert',
                      )
                    ],
                  ),
                  onTap: () {
                    if (widget.node.children.isEmpty) return;
                    nodeIsOpenCubit.clickOnNode();
                  },
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: widget.node.children.values.map((child) {
                      return TreeNodeWidget(
                        node: child,
                        level: widget.level + 1,
                      );
                    }).toList(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
