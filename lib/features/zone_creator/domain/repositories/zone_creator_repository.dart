import 'package:botanic_visit_guide/core/errors/failure.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';
import 'package:dartz/dartz.dart';

abstract class ZoneCreatorRepository {
  Future<Either<Failure, ZoneCreator>> getZoneInformation(int zoneId);
}
