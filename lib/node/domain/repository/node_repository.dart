import 'package:dartz/dartz.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/utils/exceptions/failures.dart';

abstract class INodeRepository {
  Future<Either<Failure, List<Company>>> getCompanies();
  Future<Either<Failure, List<TreeNode>>> getLocations(String companyId);
  Future<Either<Failure, List<TreeNode>>> getAssets(String companyId);
}
