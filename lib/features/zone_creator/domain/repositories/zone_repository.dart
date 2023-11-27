import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:dartz/dartz.dart';

abstract class ZoneRepository {
  Future<Either<Failure, List<ZoneInfo>>> getAllZones();
  // Future<Either<Failure, Zone>> getZoneById(int id);
  Future<Either<Failure, void>> addZone(ZoneInfo zone);
}
