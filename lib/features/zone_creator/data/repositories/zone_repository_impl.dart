import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/zone_info.dart';
import '../../domain/repositories/zone_repository.dart';
import '../datasources/local/zone_creator_local_datasource.dart';
import '../models/zone_model.dart';

class ZoneRepositoryImpl implements ZoneRepository {
  final ZoneCreatorLocalDataSource localDataSource;

  ZoneRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addZone(ZoneInfo newZone) async {
    try {
      ZoneModel zoneModel = ZoneModel.fromEntity(newZone);
      await localDataSource.addZone(zoneModel);
      return Future.value(right(null));
    } on CacheException {
      return Future.value(left(CacheException()));
    }
  }

  @override
  Future<Either<Failure, List<ZoneInfo>>> getAllZones() async {
    try {
      final zones = await localDataSource.getAllZones();
      final zoneInfos = zones.map(_mapZoneModelToZoneInfo).toList();
      return right(zoneInfos);
    } on CacheException {
      return left(CacheException());
    }
  }

  ZoneInfo _mapZoneModelToZoneInfo(ZoneModel zoneModel) {
    return ZoneInfo(
        zoneId: zoneModel.zoneId,
        name: zoneModel.name,
        waypoints: zoneModel.waypoints);
  }
}
