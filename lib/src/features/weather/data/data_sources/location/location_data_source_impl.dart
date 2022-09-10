import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/core/errors/exceptions.dart';
import 'package:weather_app/src/core/geolocator/geolocator_service.dart';

import 'location_data_source.dart';

class LocationDataSourceImpl extends LocationDataSource {
  @override
  Future<Position> fetchDevicePosition() async {
    try {
      final position = await GeoLocatorService.fetchCurrentLocation();
      return position;
    } catch (e) {
      throw LocationException(errMsg: '$e');
    }
  }

  @override
  Future<void> requestPermission() async {
    try {
      bool access = await GeoLocatorService.checkPermission();
      if (!access) {
        access = await GeoLocatorService.requestPermission();
        if (!access) {
          access = await GeoLocatorService.openAppSetting();
          if (!access) {
            throw LocationException(
              errMsg: 'Location permission must be acquired*',
            );
          }
        }
      }
    } catch (e) {
      throw LocationException(errMsg: '$e');
    }
  }
}
