import 'package:botanic_visit_guide/core/errors/failures.dart';

import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/zone_creator_repository.dart';

class ZoneCreatorRepositoryImpl implements ZoneCreatorRepository {
  @override
  Future<Either<Failure, ZoneCreator>> getZoneInformation(int zoneId) {
    // TODO: implement getZoneInformation
    throw UnimplementedError();
  }
}
