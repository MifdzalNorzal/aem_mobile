class ChartBarModel {
  final String? label;
  final double value;
  final double? value2;
  final double? value3;

  const ChartBarModel({
    this.label,
    required this.value,
    this.value2,
    this.value3,
  });

  factory ChartBarModel.fromJson(Map<String, dynamic> json) {
    double extractNum(List<String> keys) {
      for (final k in keys) {
        if (json[k] != null) return (json[k] as num).toDouble();
      }
      return 0.0;
    }

    return ChartBarModel(
      label: json['label']?.toString() ??
          json['name']?.toString() ??
          json['month']?.toString() ??
          json['day']?.toString() ??
          json['category']?.toString(),
      value: extractNum(['value', 'value1', 'count', 'amount', 'y', 'total']),
      value2: json['value2'] != null ? (json['value2'] as num).toDouble() : null,
      value3: json['value3'] != null ? (json['value3'] as num).toDouble() : null,
    );
  }
}
