class ApiException implements Exception {
  ApiException(this.message, {this.code, this.statusCode, this.fieldErrors});

  final String message;
  final String? code;
  final int? statusCode;
  final Map<String, List<String>>? fieldErrors;

  @override
  String toString() => 'ApiException: $message (${code ?? statusCode})';
}
