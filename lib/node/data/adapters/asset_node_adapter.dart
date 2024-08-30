import 'package:tractian/node/domain/entities/asset_node.dart';

class AssetNodeAdapter {
  AssetNodeAdapter._();

  /// Adaptate a json into [List<AssetNode>]
  static List<AssetNode> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map(
          (asset) => AssetNode(
            id: asset['id'],
            name: asset['name'],
            gatewayId: asset['gatewayId'],
            locationId: asset['locationId'],
            parentId: asset['parentId'],
            sensorId: asset['sensorId'],
            sensorType: asset['sensorType'],
            status: asset['status'],
          ),
        )
        .toList();
  }
}
