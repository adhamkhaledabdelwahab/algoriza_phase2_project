import 'package:weather_app/src/features/weather/domain/entities/common_entity/location_data_entity.dart';

class LocationDataModel extends LocationDataEntity {
  static const _nameKey = 'name';
  static const _regionKey = 'region';
  static const _countryKey = 'country';
  static const _latitudeKey = 'lat';
  static const _longitudeKey = 'lon';
  static const _timeZoneIdKey = 'tz_id';

  const LocationDataModel({
    required String name,
    required String country,
    String? region,
    required double latitude,
    required double longitude,
    required String timeZoneId,
  }) : super(
          name: name,
          country: country,
          region: region,
          latitude: latitude,
          longitude: longitude,
          timeZoneId: timeZoneId,
        );

  Map<String, dynamic> toJson() {
    return {
      _nameKey: name,
      _regionKey: region,
      _countryKey: country,
      _latitudeKey: latitude,
      _longitudeKey: longitude,
      _timeZoneIdKey: timeZoneId,
    };
  }

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      name: json[_nameKey],
      region: json[_regionKey],
      country: json[_countryKey],
      latitude: json[_latitudeKey],
      longitude: json[_longitudeKey],
      timeZoneId: json[_timeZoneIdKey],
    );
  }
}
