class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}
