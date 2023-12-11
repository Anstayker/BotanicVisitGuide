import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/zone_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/repositories/zone_finder_repository.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_zone_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneFinderRepository extends Mock implements ZoneFinderRepository {}

void main() {
  late GetZoneData usecase;
  late MockZoneFinderRepository mockZoneFinderRepository;

  setUp(() {
    mockZoneFinderRepository = MockZoneFinderRepository();
    usecase = GetZoneData(mockZoneFinderRepository);
  });

  const tZoneId = '1';
  const tWaypoints =
      WaypointData(waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
  const tZoneData = ZoneData(
      zoneId: '1',
      zoneName: 'zoneName',
      zoneDescription: 'zoneDescription',
      waypoints: [tWaypoints]);
  const tParams = Params(zoneId: tZoneId);

  test('should get zone data for the id from the repository', () async {
    when(() => mockZoneFinderRepository.getZoneData(any()))
        .thenAnswer((_) async => const Right(tZoneData));

    final result = await usecase(tParams);

    expect(result, const Right(tZoneData));
    verify(() => mockZoneFinderRepository.getZoneData(tZoneId));
    verifyNoMoreInteractions(mockZoneFinderRepository);
  });

  test('should return failure when repository call is unsuccessful', () async {
    when(() => mockZoneFinderRepository.getZoneData(any()))
        .thenAnswer((_) async => Left(CacheFailure()));

    final result = await usecase(tParams);

    expect(result, Left(CacheFailure()));
    verify(() => mockZoneFinderRepository.getZoneData(tZoneId));
    verifyNoMoreInteractions(mockZoneFinderRepository);
  });
}
