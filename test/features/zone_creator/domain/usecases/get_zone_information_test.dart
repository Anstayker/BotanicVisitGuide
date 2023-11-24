import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/repositories/zone_creator_repository.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/usecases/get_zone_information.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneCreatorRepository extends Mock implements ZoneCreatorRepository {}

void main() {
  late GetZoneInformation usecase;
  late MockZoneCreatorRepository mockZoneCreatorRepository;

  setUp(() {
    mockZoneCreatorRepository = MockZoneCreatorRepository();
    usecase = GetZoneInformation(mockZoneCreatorRepository);
  });

  const tZoneInformation = ZoneCreator(zoneId: 1, zoneName: 'Zone 1');

  test(
    "Should get zone information from the repository",
    () async {
      // arrange
      when(() => mockZoneCreatorRepository.getZoneInformation(any()))
          .thenAnswer((_) async => const Right(tZoneInformation));
      // act
      final result = await usecase(const Params(zoneId: 1));
      late ZoneCreator zoneInformationResult;
      result.fold(
        (failure) => null,
        (zoneCreator) {
          zoneInformationResult = zoneCreator;
        },
      );
      // assert
      expect(zoneInformationResult.zoneId, tZoneInformation.zoneId);
      expect(zoneInformationResult.zoneName, tZoneInformation.zoneName);
      verify(() => mockZoneCreatorRepository
          .getZoneInformation(tZoneInformation.zoneId));
      verifyNoMoreInteractions(mockZoneCreatorRepository);
    },
  );
}
