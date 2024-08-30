import 'package:http/http.dart' as http;
import 'package:tractian/utils/env_utils.dart';

class NodeDatasource {
  final http.Client client;

  const NodeDatasource(this.client);

  Future<http.Response> getCompanies() async {
    final response =
        await client.get(Uri.parse('${EnvUtils.apiUrl}/companies'));

    return response;
  }

  Future<http.Response> getAssets(String companyId) async {
    final response = await client
        .get(Uri.parse('${EnvUtils.apiUrl}/companies/$companyId/assets'));

    return response;
  }

  Future<http.Response> getLocations(String companyId) async {
    final response = await client
        .get(Uri.parse('${EnvUtils.apiUrl}/companies/$companyId/locations'));

    return response;
  }
}
