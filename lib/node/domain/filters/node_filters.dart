/// Filters applied to [AssetsPage] and in [filteredNodes]
class NodeFilters {
  /// Filter based on name
  final String? query;

  /// Filter based on sensorType
  final bool filterByEnergySensor;

  /// Filter based on status
  final bool filterByAlert;

  NodeFilters({
    this.query,
    this.filterByEnergySensor = false,
    this.filterByAlert = false,
  });

  NodeFilters copyWith({
    String? query,
    bool? filterByEnergySensor,
    bool? filterByAlert,
  }) {
    return NodeFilters(
      query: query ?? this.query,
      filterByEnergySensor: filterByEnergySensor ?? this.filterByEnergySensor,
      filterByAlert: filterByAlert ?? this.filterByAlert,
    );
  }
}
