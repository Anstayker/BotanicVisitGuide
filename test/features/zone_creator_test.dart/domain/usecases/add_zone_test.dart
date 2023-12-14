import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/repositories/zone_repository.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/usecases/add_zone.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockZoneRepository extends Mock implements ZoneRepository {}

void main() {
  late MockZoneRepository mockZoneRepository;
  late AddZone addZone;

  setUp(() {
    mockZoneRepository = MockZoneRepository();
    addZone = AddZone(mockZoneRepository);
  });

  const tWaypoiont =
      WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);
  const tZoneInfo =
      ZoneInfo(zoneId: '1', name: 'Zona 1', waypoints: [tWaypoiont]);

  test(
    "should add a zone to the repository",
    () async {
      // arrange
      when(() => mockZoneRepository.addZone(tZoneInfo, []))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await addZone(const Params(zone: tZoneInfo, images: []));
      // assert
      expect(result, const Right(null));
      verify(() => mockZoneRepository.addZone(tZoneInfo, []));
      verifyNoMoreInteractions(mockZoneRepository);
    },
  );
}
