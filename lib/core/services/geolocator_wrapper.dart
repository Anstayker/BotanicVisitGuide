import 'package:geolocator/geolocator.dart';

class GeolocatorWrapper {
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();
  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();
}
