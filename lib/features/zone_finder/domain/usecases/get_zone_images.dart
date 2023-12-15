import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/zone_finder_repository.dart';

class GetZoneImages implements UseCase<List<String>, Params> {
  final ZoneFinderRepository repository;

  GetZoneImages(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(Params params) async {
    return await repository.getZoneImages(params.zoneId);
  }
}

class Params extends Equatable {
  final String zoneId;

  const Params({required this.zoneId});

  @override
  List<Object> get props => [zoneId];
}
