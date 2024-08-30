import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tractian/node/data/adapters/asset_node_adapter.dart';
import 'package:tractian/node/data/adapters/company_adapter.dart';
import 'package:tractian/node/data/adapters/location_node_adapter.dart';
import 'package:tractian/node/data/datasource/node_datasource.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/node/domain/repository/node_repository.dart';
import 'package:tractian/utils/exceptions/failures.dart';

class NodeRepository implements INodeRepository {
  final NodeDatasource datasource;

  NodeRepository(this.datasource);

  /// Return a [ServerFailure] or a [List<Company>]
  @override
  Future<Either<Failure, List<Company>>> getCompanies() async {
    try {
      final response = await datasource.getCompanies();

      final body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

      final companyList = CompanyAdapter.fromJson(body);

      return Right(companyList);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  /// Return a [ServerFailure] or a [List<TreeNode>]
  @override
  Future<Either<Failure, List<TreeNode>>> getAssets(String companyId) async {
    try {
      final response = await datasource.getAssets(companyId);

      final body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

      final assetsList = AssetNodeAdapter.fromJson(body);

      return Right(assetsList);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  /// Return a [ServerFailure] or a [List<TreeNode>]
  @override
  Future<Either<Failure, List<TreeNode>>> getLocations(String companyId) async {
    try {
      final response = await datasource.getLocations(companyId);

      final body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

      final locationsList = LocationNodeAdapter.fromJson(body);

      return Right(locationsList);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
