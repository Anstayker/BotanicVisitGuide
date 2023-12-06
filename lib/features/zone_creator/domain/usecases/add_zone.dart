import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zone_info.dart';
import '../repositories/zone_repository.dart';

class AddZone implements UseCase<void, Params> {
  final ZoneRepository repository;
  AddZone(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    await repository.addZone(params.zone);
    return const Right(null);
  }
}

class Params extends Equatable {
  final ZoneInfo zone;

  const Params({required this.zone});

  @override
  List<Object?> get props => [zone];
}
