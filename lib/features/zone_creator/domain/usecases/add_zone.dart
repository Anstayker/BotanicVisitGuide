import 'dart:io';

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
    await repository.addZone(params.zone, params.images, params.audio);
    return const Right(null);
  }
}

class Params extends Equatable {
  final ZoneInfo zone;
  final List<File> images;
  final File? audio;

  const Params({required this.zone, required this.images, required this.audio});

  @override
  List<Object?> get props => [zone];
}
