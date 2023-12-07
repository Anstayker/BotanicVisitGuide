import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/core/services/geolocator_wrapper.dart';
import 'package:botanic_visit_guide/core/services/gps_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocator extends Mock implements GeolocatorWrapper {}

void main() {
  late GpsServiceImpl gpsService;
  late MockGeolocator mockGeolocator;

  setUp(() {
    mockGeolocator = MockGeolocator();
    gpsService = GpsServiceImpl(geolocator: mockGeolocator);
  });

  group('get currentPosition', () {
    final tDateTime = DateTime(2017, 9, 7, 17, 30);
    final tPosition = Position(
        longitude: 0,
        latitude: 0,
        timestamp: tDateTime,
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0);

    test(
      "should forward the call to Geolocator.getCurrentPosition if permission was granted",
      () async {
        // arrange
        when(() => mockGeolocator.checkPermission())
            .thenAnswer((_) async => LocationPermission.always);
        when(() => mockGeolocator.requestPermission())
            .thenAnswer((_) async => LocationPermission.always);
        when(() => mockGeolocator.getCurrentPosition())
            .thenAnswer((_) async => tPosition);
        // act
        final result = await gpsService.currentPosition;
        // assert
        verify(() => mockGeolocator.getCurrentPosition()).called(1);
        expect(result, equals(Right(tPosition)));
      },
    );

    test(
      "should return failure if permission wasn't granted",
      () async {
        // arrange
        when(() => mockGeolocator.checkPermission())
            .thenAnswer((_) async => LocationPermission.denied);
        when(() => mockGeolocator.requestPermission())
            .thenAnswer((_) async => LocationPermission.denied);
        // act
        final result = await gpsService.currentPosition;
        // assert
        expect(result, equals(Left(PermissionException())));
      },
    );
  });
}
