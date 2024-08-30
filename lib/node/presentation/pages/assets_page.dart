import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:tractian/node/data/datasource/node_datasource.dart';
import 'package:tractian/node/data/repository/node_repository.dart';
import 'package:tractian/node/domain/usecases/get_nodes_usecase.dart';
import 'package:tractian/node/domain/usecases/order_nodes_usecase.dart';
import 'package:tractian/node/presentation/blocs/node/node_bloc.dart';
import 'package:tractian/node/presentation/widgets/filter_nodes_text_field.dart';
import 'package:tractian/node/presentation/widgets/filter_nodes_widget.dart';
import 'package:tractian/node/presentation/widgets/tree_node_widget.dart';
import 'package:tractian/theme/theme_colors.dart';
import 'package:tractian/utils/error_page.dart';
import 'package:tractian/utils/request_status.dart';
import 'package:tractian/utils/tractian_icons.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;
  const AssetsPage({
    super.key,
    required this.companyId,
  });

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final NodeBloc nodeBloc;

  @override
  void initState() {
    super.initState();
    final Client client = Client();
    final NodeDatasource nodeDatasource = NodeDatasource(client);
    final NodeRepository nodeRepository = NodeRepository(nodeDatasource);
    nodeBloc = NodeBloc(
      getNodesUsecase: GetNodesUsecase(nodeRepository),
      orderNodesUsecase: OrderNodesUsecase(),
    )..add(
        FetchNodesEvent(companyId: widget.companyId),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            TractianIcons.arrow_left,
            color: ThemeColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Assets',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      body: BlocProvider<NodeBloc>.value(
        value: nodeBloc,
        child: BlocBuilder<NodeBloc, NodeState>(
          bloc: nodeBloc,
          builder: (context, state) {
            switch (state.nodesStatus) {
              case RequestStatus.initial:
              case RequestStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestStatus.failure:
                return ErrorPage(
                  message:
                      'Erro ao Carregar os Assets!\nClique para tentar novamente',
                  onTap: () => nodeBloc.add(
                    FetchNodesEvent(companyId: widget.companyId),
                  ),
                );

              default:
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        right: 18,
                        top: 12,
                        bottom: 4,
                      ),
                      child: FilterNodesTextField(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: FilterNodesWidget(),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: state.filteredNodes.values
                            .map(
                              (node) => TreeNodeWidget(node: node),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
