import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ZoneCreatorLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = ZoneCreatorLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getAllZones', () {
    final tZoneListJson = fixture('zone_creator_cached.json');
    final tZoneList = (jsonDecode(tZoneListJson) as List)
        .map((item) => ZoneModel.fromJson(item))
        .toList();

    test(
      "Should return list of ZoneModels from the cache",
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any()))
            .thenReturn(tZoneListJson);
        // act
        final result = await localDataSource.getAllZones();
        // assert
        verify(() => mockSharedPreferences.getString('CACHE_ZONES_LIST'));
        expect(result, equals(tZoneList));
      },
    );
  });
}
