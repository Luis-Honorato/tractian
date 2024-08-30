import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/node/data/datasource/node_datasource.dart';
import 'package:tractian/node/data/repository/node_repository.dart';
import 'package:tractian/utils/exceptions/failures.dart';

import '../../node_utils/node_utils.dart';
import 'node_repository_test.mocks.dart';

@GenerateMocks([NodeDatasource])
void main() {
  late final MockNodeDatasource mockNodeDatasource;
  late final NodeRepository repository;

  setUpAll(() {
    mockNodeDatasource = MockNodeDatasource();
    repository = NodeRepository(mockNodeDatasource);
  });

  test('Should return a list of company when call getCompanies', () async {
    const companiesExpectedList = NodeUtilsTest.fakeCompaniesList;
    when(mockNodeDatasource.getCompanies()).thenAnswer((_) async =>
        Response(jsonEncode(NodeUtilsTest.companiesJsonList), 200));

    final companiesResult = await repository.getCompanies();

    /// Call must be success
    expect(true, equals(companiesResult.isRight()));

    final companiesList =
        companiesResult.fold((l) => null, (companies) => companies);

    /// First index must be equal
    expect(companiesList!.first.id, equals(companiesExpectedList.first.id));

    /// Last index must be equal
    expect(companiesList.last.id, equals(companiesExpectedList.last.id));
  });

  test('Should return ServerFailure when getCompanies failures', () async {
    when(mockNodeDatasource.getCompanies())
        .thenAnswer((_) async => Response('', 400));

    final companiesResult = await repository.getCompanies();

    /// Call must be failure
    expect(true, equals(companiesResult.isLeft()));

    final failure = companiesResult.fold((failure) => failure, (r) => null);
    expect(failure, isA<Failure>());
    expect(failure, isA<ServerFailure>());
  });

  test('Should return a list of assets when call getAssets', () async {
    final assetsExpectedList = NodeUtilsTest.fakeAssetsList;
    when(mockNodeDatasource.getAssets(any)).thenAnswer(
        (_) async => Response(jsonEncode(NodeUtilsTest.assetsJsonList), 200));

    final assetsResult = await repository.getAssets('any');

    /// Call must be success
    expect(true, equals(assetsResult.isRight()));

    final assetsList = assetsResult.fold((l) => null, (assets) => assets);

    /// First index must be equal
    expect(assetsList!.first.id, equals(assetsExpectedList.first.id));

    /// Last index must be equal
    expect(assetsList.last.id, equals(assetsExpectedList.last.id));
  });

  test('Should return ServerFailure when getAssets failures', () async {
    when(mockNodeDatasource.getAssets(any))
        .thenAnswer((_) async => Response('', 400));

    final assetsResult = await repository.getAssets('any');

    /// Call must be failure
    expect(true, equals(assetsResult.isLeft()));

    final failure = assetsResult.fold((failure) => failure, (r) => null);
    expect(failure, isA<Failure>());
    expect(failure, isA<ServerFailure>());
  });

  test('Should return a list of locations when call getLocations', () async {
    final assetsExpectedList = NodeUtilsTest.fakeLocationsList;
    when(mockNodeDatasource.getLocations(any)).thenAnswer((_) async =>
        Response(jsonEncode(NodeUtilsTest.jsonLocationsList), 200));

    final locationsResult = await repository.getLocations('any');

    /// Call must be success
    expect(true, equals(locationsResult.isRight()));

    final lcoationsList =
        locationsResult.fold((l) => null, (locations) => locations);

    /// First index must be equal
    expect(lcoationsList!.first.id, equals(assetsExpectedList.first.id));

    /// Last index must be equal
    expect(lcoationsList.last.id, equals(assetsExpectedList.last.id));
  });

  test('Should return ServerFailure when getLocations failures', () async {
    when(mockNodeDatasource.getLocations(any))
        .thenAnswer((_) async => Response('', 400));

    final locationsResult = await repository.getLocations('any');

    /// Call must be failure
    expect(true, equals(locationsResult.isLeft()));

    final failure = locationsResult.fold((failure) => failure, (r) => null);
    expect(failure, isA<Failure>());
    expect(failure, isA<ServerFailure>());
  });
}
