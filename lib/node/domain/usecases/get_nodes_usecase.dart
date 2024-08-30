import 'package:dartz/dartz.dart';
import 'package:tractian/node/domain/entities/tree_node.dart';
import 'package:tractian/node/domain/repository/node_repository.dart';
import 'package:tractian/utils/exceptions/failures.dart';

class GetNodesUsecase {
  final INodeRepository nodeRepository;

  GetNodesUsecase(this.nodeRepository);

  /// Fetch a list of [TreeNode] from an [Company], based on [companyId]
  Future<Either<Failure, List<TreeNode>>> call(String companyId) async {
    /// Get the [locations] and [assets] results from [nodeRepository]
    final assetsResult = await nodeRepository.getAssets(companyId);
    final locationsResult = await nodeRepository.getLocations(companyId);

    /// Returns [Failure] if any result is Left
    if (assetsResult.isLeft() || locationsResult.isLeft()) {
      return const Left(ServerFailure(errorMessage: 'Cannot Get Nodes'));
    }

    /// Obtains lists from results
    final assetsList = assetsResult.fold((l) => null, (assets) => assets);
    final locationsList =
        locationsResult.fold((l) => null, (locations) => locations);

    /// Creates a node list with all [assets] and [locations]
    final List<TreeNode> nodes = [...locationsList!, ...assetsList!];
    return Right(nodes);
  }
}
