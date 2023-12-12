import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/zone_info.dart';
import '../../domain/repositories/zone_repository.dart';
import '../datasources/local/zone_creator_local_datasource.dart';
import '../datasources/remote/zone_creator_remote_datasource.dart';
import '../models/zone_info_model.dart';

class ZoneRepositoryImpl implements ZoneRepository {
  final ZoneCreatorLocalDataSource localDataSource;
  final ZoneCreatorRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ZoneRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, void>> addZone(ZoneInfo newZone) async {
    if (await networkInfo.isConnected) {
      try {
        ZoneInfoModel zoneModel = ZoneInfoModel.fromEntity(newZone);
        await remoteDatasource.addNewZone(zoneModel);
        return Future.value(right(null));
      } on ServerException {
        return Future.value(left(ServerFailure()));
      }
    } else {
      return Future.value(left(NetworkFailure()));
    }
  }

  @override
  Future<Either<Failure, List<ZoneInfo>>> getAllZones() async {
    if (await networkInfo.isConnected) {
      try {
        final zones = await remoteDatasource.getAllZones();
        final zoneInfos = zones.map(_mapZoneModelToZoneInfo).toList();
        return right(zoneInfos);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final zones = await localDataSource.getAllZones();
        final zoneInfos = zones.map(_mapZoneModelToZoneInfo).toList();
        return right(zoneInfos);
      } on CacheFailure {
        return left(CacheFailure());
      }
    }
  }

  ZoneInfo _mapZoneModelToZoneInfo(ZoneInfoModel zoneModel) {
    return ZoneInfo(
      zoneId: zoneModel.zoneId,
      name: zoneModel.name,
      waypoints: zoneModel.waypoints,
    );
  }
}
