import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tractian/node/domain/repository/node_repository.dart';
import 'package:tractian/node/domain/usecases/get_nodes_usecase.dart';
import 'package:tractian/utils/exceptions/failures.dart';

import '../../node_utils/node_utils.dart';
import 'get_nodes_usecase_test.mocks.dart';

@GenerateMocks([INodeRepository])
void main() {
  late final MockINodeRepository mockNodeRepository;
  late final GetNodesUsecase usecase;

  setUpAll(() {
    mockNodeRepository = MockINodeRepository();
    usecase = GetNodesUsecase(mockNodeRepository);
  });
  test('Should return a list of assets and locations', () async {
    when(mockNodeRepository.getAssets('any'))
        .thenAnswer((_) async => Right(NodeUtilsTest.fakeAssetsList));
    when(mockNodeRepository.getLocations('any'))
        .thenAnswer((_) async => Right(NodeUtilsTest.fakeLocationsList));

    final result = await usecase('any');
    final expectedList = NodeUtilsTest.fakeNodesLists;

    final resultList = result.fold((l) => null, (nodesList) => nodesList);
    Function eq = const ListEquality().equals;
    final listsAreEqual = eq(resultList, expectedList);

    expect(listsAreEqual, equals(true));
  });

  test('Should return a serverFailure when assets is left', () async {
    when(mockNodeRepository.getAssets('any'))
        .thenAnswer((_) async => const Left(ServerFailure(errorMessage: '')));
    when(mockNodeRepository.getLocations('any'))
        .thenAnswer((_) async => Right(NodeUtilsTest.fakeLocationsList));

    final result = await usecase('any');

    /// Returns must be failure
    expect(true, equals(result.isLeft()));
    final failure = result.fold((failure) => failure, (r) => null);

    expect(failure, isA<Failure>());
    expect(failure, isA<ServerFailure>());
  });

  test('Should return a serverFailure when locations is left', () async {
    when(mockNodeRepository.getAssets('any'))
        .thenAnswer((_) async => Right(NodeUtilsTest.fakeAssetsList));
    when(mockNodeRepository.getLocations('any'))
        .thenAnswer((_) async => const Left(ServerFailure(errorMessage: '')));

    final result = await usecase('any');

    /// Returns must be failure
    expect(true, equals(result.isLeft()));
    final failure = result.fold((failure) => failure, (r) => null);

    expect(failure, isA<Failure>());
    expect(failure, isA<ServerFailure>());
  });
}
