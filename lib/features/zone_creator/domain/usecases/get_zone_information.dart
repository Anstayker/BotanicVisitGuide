import 'package:botanic_visit_guide/core/errors/failure.dart';
import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/repositories/zone_creator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetZoneInformation implements UseCase<ZoneCreator, Params> {
  final ZoneCreatorRepository repository;

  GetZoneInformation(this.repository);

  @override
  Future<Either<Failure, ZoneCreator>> call(Params params) async {
    return await repository.getZoneInformation(params.zoneId);
  }
}

class Params extends Equatable {
  final int zoneId;

  const Params({required this.zoneId});

  @override
  List<Object> get props => [zoneId];
}
