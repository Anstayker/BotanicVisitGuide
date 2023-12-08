import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/zone_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/repositories/zone_finder_repository.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_all_zones_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneFinderRepository extends Mock implements ZoneFinderRepository {}

void main() {
  late GetAllZonesData usecase;
  late MockZoneFinderRepository mockZoneFinderRepository;

  setUp(() {
    mockZoneFinderRepository = MockZoneFinderRepository();
    usecase = GetAllZonesData(mockZoneFinderRepository);
  });

  const tWaypoint = WaypointData(waypointId: 1, latitude: 1.0, longitude: 1.0);
  const tZoneData = ZoneData(
      zoneId: 1,
      zoneName: 'zoneName',
      zoneDescription: 'zoneDescription',
      waypoints: [tWaypoint]);
  final tZoneDataList = [tZoneData, tZoneData, tZoneData];

  test('should get all zones data from the repository', () async {
    // arrange
    when(() => mockZoneFinderRepository.getAllZonesData())
        .thenAnswer((_) async => Right(tZoneDataList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tZoneDataList));
    verify(() => mockZoneFinderRepository.getAllZonesData());
    verifyNoMoreInteractions(mockZoneFinderRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    final Failure failure = CacheException();
    when(() => mockZoneFinderRepository.getAllZonesData())
        .thenAnswer((_) async => Left(failure));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Left(failure));
    verify(() => mockZoneFinderRepository.getAllZonesData());
    verifyNoMoreInteractions(mockZoneFinderRepository);
  });
}
