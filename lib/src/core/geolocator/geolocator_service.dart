import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  static Future<bool> checkPermission() async {
    final perm = await Geolocator.checkPermission();
    return perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse;
  }

  static Future<bool> requestPermission() async {
    final perm = await Geolocator.requestPermission();
    return perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse;
  }

  static Future<bool> openAppSetting() async {
    final perm = await Geolocator.openAppSettings();
    return perm;
  }

  static Future<Position> fetchCurrentLocation() async {
    final perm = await Geolocator.getCurrentPosition();
    return perm;
  }
}
