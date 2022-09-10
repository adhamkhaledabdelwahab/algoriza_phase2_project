import 'package:geolocator/geolocator.dart';

abstract class LocationDataSource {
  Future<void> requestPermission();

  Future<Position> fetchDevicePosition();
}
