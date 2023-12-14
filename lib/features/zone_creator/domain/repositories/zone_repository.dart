import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/zone_info.dart';

abstract class ZoneRepository {
  Future<Either<Failure, List<ZoneInfo>>> getAllZones();
  Future<Either<Failure, void>> addZone(ZoneInfo zone, List<File>? images);
}
