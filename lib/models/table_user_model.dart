class TableUserModel {
  final int? id;
  final String name;
  final String? department;
  final String? role;
  final String? email;

  const TableUserModel({
    this.id,
    required this.name,
    this.department,
    this.role,
    this.email,
  });

  factory TableUserModel.fromJson(Map<String, dynamic> json) {
    return TableUserModel(
      id: json['id'] as int?,
      name: json['name']?.toString() ??
          json['fullName']?.toString() ??
          json['full_name']?.toString() ??
          json['username']?.toString() ??
          'Unknown',
      department: json['department']?.toString() ??
          json['departmentName']?.toString() ??
          json['team']?.toString(),
      role: json['role']?.toString() ??
          json['position']?.toString() ??
          json['jobTitle']?.toString() ??
          json['job_title']?.toString(),
      email: json['email']?.toString(),
    );
  }
}
