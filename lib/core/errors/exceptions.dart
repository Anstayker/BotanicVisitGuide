class ServerException implements Exception {}

class CacheException implements Exception {}

class PermissionException implements Exception {}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
