class ApiResponse<T> {
  final int? code;
  final String? message;
  final T? data;

  const ApiResponse({this.code, this.message, this.data});
}
