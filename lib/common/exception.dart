class ErrorServerFoundException implements Exception {}

class ErrorDatabaseFoundException implements Exception {
  final String message;

  ErrorDatabaseFoundException(this.message);
}
