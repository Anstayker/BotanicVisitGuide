import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/zone_data.dart';

abstract class ZoneFinderRepository {
  Future<Either<Failure, List<ZoneData>>> getAllZonesData();
  Future<Either<Failure, ZoneData>> getZoneData(int zoneId);
}
