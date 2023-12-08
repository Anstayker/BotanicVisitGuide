import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/zone_data.dart';
import '../../domain/repositories/zone_finder_repository.dart';
import '../datasources/zone_finder_local_datasource.dart';

class ZoneFinderRepositoryImpl implements ZoneFinderRepository {
  final ZoneFinderLocalDataSource localDataSource;

  ZoneFinderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ZoneData>>> getAllZonesData() {
    // TODO: implement getAllZonesData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ZoneData>> getZoneData(int zoneId) {
    // TODO: implement getZoneData
    throw UnimplementedError();
  }
}
