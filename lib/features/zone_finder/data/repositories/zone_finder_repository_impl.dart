import 'dart:async';

import 'package:botanic_visit_guide/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart' as exception;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/zone_data.dart';
import '../../domain/repositories/zone_finder_repository.dart';
import '../datasources/zone_finder_local_datasource.dart';
import '../datasources/zone_finder_remote_datasource.dart';
import '../models/zone_data_model.dart';

class ZoneFinderRepositoryImpl implements ZoneFinderRepository {
  final ZoneFinderLocalDataSource localDataSource;
  final ZoneFinderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ZoneFinderRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<ZoneData>>> getAllZonesData() async {
    if (await networkInfo.isConnected) {
      try {
        final zones = await remoteDataSource.getAllZones();
        final zoneDataList = zones.map(_mapZoneModelToZoneData).toList();
        return right(zoneDataList);
      } on exception.ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final zones = await localDataSource.getAllZones();
        final zoneDataList = zones.map(_mapZoneModelToZoneData).toList();
        return right(zoneDataList);
      } on exception.CacheException {
        return left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ZoneData>> getZoneData(String zoneId) async {
    if (await networkInfo.isConnected) {
      try {
        final zone = await remoteDataSource.getZoneData(zoneId);
        return right(_mapZoneModelToZoneData(zone));
      } on exception.ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final zone = await localDataSource.getZoneData(zoneId);
        return right(_mapZoneModelToZoneData(zone));
      } on exception.CacheException {
        return left(CacheFailure());
      } on exception.NotFoundException {
        return left(NotFoundFailure());
      }
    }
  }

  ZoneData _mapZoneModelToZoneData(ZoneDataModel zoneModel) {
    return ZoneData(
      zoneId: zoneModel.zoneId,
      zoneName: zoneModel.zoneName,
      zoneDescription: zoneModel.zoneDescription ?? '',
      waypoints: zoneModel.waypoints,
      images: zoneModel.images,
      audio: zoneModel.audio,
    );
  }

  @override
  Future<Either<Failure, List<String>>> getZoneImages(String zoneId) async {
    if (await networkInfo.isConnected) {
      try {
        final imageUrls = await remoteDataSource.getZonesImages(zoneId);
        return right(imageUrls);
      } on exception.ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }
}
