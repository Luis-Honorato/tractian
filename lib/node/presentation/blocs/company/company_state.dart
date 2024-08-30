part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final RequestStatus companiesStatus;
  final List<Company> companies;

  const CompanyState({
    this.companiesStatus = RequestStatus.initial,
    this.companies = const [],
  });

  CompanyState copyWith({
    RequestStatus? companiesStatus,
    RequestStatus? nodesStatus,
    List<Company>? companies,
    Map<String, dynamic>? nodes,
  }) {
    return CompanyState(
      companiesStatus: companiesStatus ?? this.companiesStatus,
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object> get props => [
        companiesStatus,
        companies,
      ];
}
