import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/repositories/zone_repository.dart';

import 'package:dartz/dartz.dart';

class ZoneRepositoryImpl implements ZoneRepository {
  @override
  Future<Either<Failure, void>> addZone(ZoneInfo zone) {
    // TODO: implement addZone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ZoneInfo>>> getAllZones() {
    // TODO: implement getAllZones
    throw UnimplementedError();
  }
}
