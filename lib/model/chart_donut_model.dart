class ChartDonutModel {
  final String? label;
  final double value;

  const ChartDonutModel({this.label, required this.value});

  factory ChartDonutModel.fromJson(Map<String, dynamic> json) {
    double extractNum(List<String> keys) {
      for (final k in keys) {
        if (json[k] != null) return (json[k] as num).toDouble();
      }
      return 0.0;
    }

    return ChartDonutModel(
      label: json['label']?.toString() ??
          json['name']?.toString() ??
          json['category']?.toString() ??
          json['title']?.toString(),
      value: extractNum(['value', 'count', 'amount', 'percentage', 'y', 'total']),
    );
  }
}
