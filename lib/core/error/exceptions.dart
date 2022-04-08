/// There are two main types of exceptions in the app.

/// [ServerException] is thrown when the server returns an error.
class ServerException implements Exception {}

/// [CacheException] is thrown when the cache returns an error.
class CacheException implements Exception {}

/// [AuthException] is thrown when the auth returns an error.
class AuthException implements Exception {}
