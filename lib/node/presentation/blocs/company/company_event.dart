part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

/// Called when user open [HomePage]
class FetchCompaniesEvent extends CompanyEvent {}
