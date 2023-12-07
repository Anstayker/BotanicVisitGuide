import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerException extends Failure {}

class CacheException extends Failure {}

class PermissionException extends Failure {}
