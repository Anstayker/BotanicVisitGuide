import 'package:botanic_visit_guide/core/services/geolocator_wrapper.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../errors/failures.dart';

abstract class GpsService {
  Future<Either<Failure, Position>> get currentPosition;
}

class GpsServiceImpl implements GpsService {
  final GeolocatorWrapper geolocator;

  GpsServiceImpl({required this.geolocator});

  @override
  Future<Either<Failure, Position>> get currentPosition async {
    LocationPermission permission;
    permission = await geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(PermissionException());
      }
    }

    Position position = await geolocator.getCurrentPosition();
    return Right(position);
  }
}
