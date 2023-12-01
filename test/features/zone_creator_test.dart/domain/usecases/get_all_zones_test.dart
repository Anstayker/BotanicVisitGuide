import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/repositories/zone_repository.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/usecases/get_all_zones.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneRepository extends Mock implements ZoneRepository {}

void main() {
  late GetAllZones getAllZones;
  late MockZoneRepository mockZoneRepository;

  setUp(() {
    mockZoneRepository = MockZoneRepository();
    getAllZones = GetAllZones(mockZoneRepository);
  });

  const tZones = [
    ZoneInfo(zoneId: 1, name: 'Zona 1', waypoints: []),
    ZoneInfo(zoneId: 2, name: 'Zona 2', waypoints: [])
  ];

  test(
    "should get all zones from the repository",
    () async {
      // arrange
      when(() => mockZoneRepository.getAllZones())
          .thenAnswer((_) async => const Right(tZones));
      // act
      final result = await getAllZones(NoParams());
      // assert
      expect(result, const Right(tZones));
      verify(() => mockZoneRepository.getAllZones());
      verifyNoMoreInteractions(mockZoneRepository);
    },
  );

  // TODO test failure
  test(
    "should return failure when the repository fails",
    () async {
      // arrange
    },
  );
}
