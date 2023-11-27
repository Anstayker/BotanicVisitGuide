import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zone_info.dart';
import '../repositories/zone_repository.dart';

class GetAllZones implements UseCase<List<ZoneInfo>, NoParams> {
  final ZoneRepository repository;
  GetAllZones(this.repository);

  @override
  Future<Either<Failure, List<ZoneInfo>>> call(NoParams params) async {
    return await repository.getAllZones();
  }
}
