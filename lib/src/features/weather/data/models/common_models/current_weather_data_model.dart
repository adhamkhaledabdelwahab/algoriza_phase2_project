// ignore_for_file: non_constant_identifier_names, constant_identifier_names, equal_keys_in_map

import 'package:weather_app/src/features/weather/domain/entities/common_entity/current_weather_data_entity.dart';
import 'weather_condition_data_model.dart';

class CurrentWeatherDataModel extends CurrentWeatherDataEntity {
  static const String _last_updatedKey = 'last_updated_epoch';
  static const String _temp_cKey = 'temp_c';
  static const String _feelsLike_cKey = 'feelslike_c';
  static const String weatherConditionDataKey = 'condition';
  static const String _wind_kphKey = 'wind_kph';
  static const String _humidityKey = 'humidity';
  static const String _uvKey = 'uv';

  const CurrentWeatherDataModel({
    required DateTime last_updated,
    required double temp_c,
    required double feelsLike_c,
    required WeatherConditionDataModel weatherConditionDataModel,
    required double wind_kph,
    required int humidity,
    required double uv,
  }) : super(
          last_updated: last_updated,
          temp_c: temp_c,
          feelsLike_c: feelsLike_c,
          weatherConditionDataEntity: weatherConditionDataModel,
          wind_kph: wind_kph,
          humidity: humidity,
          uv: uv,
        );

  Map<String, dynamic> toJson() {
    return {
      _last_updatedKey: last_updated,
      _temp_cKey: temp_c,
      _feelsLike_cKey: feelsLike_c,
      weatherConditionDataKey: weatherConditionDataEntity,
      _wind_kphKey: wind_kph,
      _humidityKey: humidity,
      _uvKey: uv,
    };
  }

  factory CurrentWeatherDataModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherDataModel(
      last_updated: DateTime.fromMillisecondsSinceEpoch(
        json[_last_updatedKey] * 1000,
      ),
      temp_c: json[_temp_cKey],
      feelsLike_c: json[_feelsLike_cKey],
      weatherConditionDataModel: WeatherConditionDataModel.fromJson(
        json[weatherConditionDataKey],
      ),
      wind_kph: json[_wind_kphKey],
      humidity: json[_humidityKey],
      uv: json[_uvKey],
    );
  }
}
