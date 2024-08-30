import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/web.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/domain/usecases/get_companies_usecase.dart';
import 'package:tractian/utils/request_status.dart';

part 'company_event.dart';
part 'company_state.dart';

final _companyLogger = Logger();

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompaniesUsecase getCompaniesUsecase;

  CompanyBloc({
    required this.getCompaniesUsecase,
  }) : super(CompanyState()) {
    on<FetchCompaniesEvent>((event, emit) async {
      emit(state.copyWith(
        companiesStatus: RequestStatus.loading,
      ));

      final result = await getCompaniesUsecase();

      result.fold((failure) {
        emit(state.copyWith(
          companiesStatus: RequestStatus.failure,
        ));
        _companyLogger.w('Error while fetching Companies');
      }, (companies) {
        emit(state.copyWith(
          companiesStatus: RequestStatus.success,
          companies: companies,
        ));
        _companyLogger.i('Succes while fetching Companies');
      });
    });
  }
}
