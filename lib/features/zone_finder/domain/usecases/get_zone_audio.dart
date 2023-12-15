import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/repositories/zone_finder_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';

class GetZoneAudio implements UseCase<String, Params> {
  final ZoneFinderRepository repository;

  GetZoneAudio(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.getZoneAudio(params.zoneId);
  }
}

class Params extends Equatable {
  final String zoneId;

  const Params({required this.zoneId});

  @override
  List<Object> get props => [zoneId];
}
