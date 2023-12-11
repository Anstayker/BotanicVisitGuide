import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zone_data.dart';
import '../repositories/zone_finder_repository.dart';

class GetZoneData implements UseCase<ZoneData, Params> {
  final ZoneFinderRepository repository;
  GetZoneData(this.repository);

  @override
  Future<Either<Failure, ZoneData>> call(params) {
    return repository.getZoneData(params.zoneId);
  }
}

class Params extends Equatable {
  final String zoneId;

  const Params({required this.zoneId});

  @override
  List<Object?> get props => [zoneId];
}
