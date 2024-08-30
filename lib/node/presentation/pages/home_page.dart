import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:tractian/node/data/datasource/node_datasource.dart';
import 'package:tractian/node/data/repository/node_repository.dart';
import 'package:tractian/node/domain/usecases/get_companies_usecase.dart';
import 'package:tractian/node/presentation/blocs/company/company_bloc.dart';
import 'package:tractian/node/presentation/widgets/companies_list.dart';
import 'package:tractian/theme/theme_colors.dart';
import 'package:tractian/utils/error_page.dart';
import 'package:tractian/utils/request_status.dart';
import 'package:tractian/utils/tractian_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CompanyBloc companyBloc;
  @override
  void initState() {
    super.initState();
    final Client client = Client();
    final NodeDatasource nodeDatasource = NodeDatasource(client);
    final NodeRepository nodeRepository = NodeRepository(nodeDatasource);
    companyBloc = CompanyBloc(
      getCompaniesUsecase: GetCompaniesUsecase(nodeRepository),
    )..add(FetchCompaniesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.sizeOf(context).width / 3,
          ),
          child: const Icon(
            TractianIcons.logo_tractian,
            size: 22,
            color: ThemeColors.white,
          ),
        ),
      ),
      body: BlocProvider.value(
        value: companyBloc,
        child: BlocBuilder<CompanyBloc, CompanyState>(
          bloc: companyBloc,
          buildWhen: (previous, current) =>
              previous.companiesStatus != current.companiesStatus,
          builder: (context, state) {
            switch (state.companiesStatus) {
              case RequestStatus.initial:
              case RequestStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestStatus.failure:
                return ErrorPage(
                  message:
                      'Erro ao Carregar as Empresas!\nClique para tentar novamente',
                  onTap: () => companyBloc.add(FetchCompaniesEvent()),
                );

              default:
                return CompaniesList(companies: state.companies);
            }
          },
        ),
      ),
    );
  }
}
