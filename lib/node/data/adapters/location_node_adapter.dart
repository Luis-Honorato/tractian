import 'package:tractian/node/domain/entities/location_node.dart';

class LocationNodeAdapter {
  LocationNodeAdapter._();

  /// Adaptate a json into [List<LocationNode>]
  static List<LocationNode> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map((location) => LocationNode(
              id: location['id'],
              name: location['name'],
              parentId: location['parentId'],
              locationId: location['locationId'],
            ))
        .toList();
  }
}
