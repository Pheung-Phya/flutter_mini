class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Server error occurred"]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "No internet connection"]);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Unauthorized"]);

  @override
  String toString() => message;
}
