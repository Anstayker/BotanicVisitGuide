import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zone_data.dart';
import '../repositories/zone_finder_repository.dart';

class GetAllZonesData implements UseCase<List<ZoneData>, NoParams> {
  final ZoneFinderRepository repository;
  GetAllZonesData(this.repository);

  @override
  Future<Either<Failure, List<ZoneData>>> call(NoParams params) async {
    return repository.getAllZonesData();
  }
}
