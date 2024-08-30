import 'package:dartz/dartz.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/domain/repository/node_repository.dart';
import 'package:tractian/utils/exceptions/failures.dart';

class GetCompaniesUsecase {
  final INodeRepository repository;

  GetCompaniesUsecase(this.repository);

  /// Fetch a list of [Company]
  Future<Either<Failure, List<Company>>> call() async {
    return await repository.getCompanies();
  }
}
