import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart' as exception;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/zone_data.dart';
import '../../domain/repositories/zone_finder_repository.dart';
import '../datasources/zone_finder_local_datasource.dart';

class ZoneFinderRepositoryImpl implements ZoneFinderRepository {
  final ZoneFinderLocalDataSource localDataSource;

  ZoneFinderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ZoneData>>> getAllZonesData() async {
    try {
      final zones = await localDataSource.getAllZones();
      final zoneDataList = zones.map(_mapZoneModelToZoneData).toList();
      return right(zoneDataList);
    } on exception.CacheException {
      return Future.value(left(CacheFailure()));
    }
  }

  @override
  Future<Either<Failure, ZoneData>> getZoneData(String zoneId) {
    try {
      final zone = localDataSource.getZoneData(zoneId);
      return zone.then((value) => right(_mapZoneModelToZoneData(value)));
    } on exception.CacheException {
      return Future.value(left(CacheFailure()));
    } on exception.NotFoundException {
      return Future.value(left(NotFoundFailure()));
    }
  }

  ZoneData _mapZoneModelToZoneData(ZoneDataModel zoneModel) {
    return ZoneData(
      zoneId: zoneModel.zoneId,
      zoneName: zoneModel.name,
      zoneDescription: zoneModel.description ?? '',
      waypoints: zoneModel.waypoints,
    );
  }
}
