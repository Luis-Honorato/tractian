import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/node/data/datasource/node_datasource.dart';

import 'node_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late final MockClient mockClient;
  late final NodeDatasource datasource;

  setUpAll(() {
    mockClient = MockClient();
    datasource = NodeDatasource(mockClient);
  });

  final fakeResponseOK = http.Response('{any}', 200);
  final fakeResponseError = http.Response('', 400);

  test('Should return Status 200 when getCompanies', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseOK);

    final response = await datasource.getCompanies();

    expect(response, equals(fakeResponseOK));
  });

  test('Should return Status 400 when failure on call getCompanies', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseError);

    final response = await datasource.getCompanies();

    expect(response, equals(fakeResponseError));
  });

  test('Should return Status 200 when getAssets', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseOK);

    final response = await datasource.getAssets('');

    expect(response, equals(fakeResponseOK));
  });

  test('Should return Status 400 when failure on call getAssets', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseError);

    final response = await datasource.getAssets('');

    expect(response, equals(fakeResponseError));
  });

  test('Should return Status 200 when getLocations', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseOK);

    final response = await datasource.getLocations('');

    expect(response, equals(fakeResponseOK));
  });

  test('Should return Status 400 when failure on call getLocations', () async {
    when(mockClient.get(any)).thenAnswer((_) async => fakeResponseError);

    final response = await datasource.getLocations('');

    expect(response, equals(fakeResponseError));
  });
}
