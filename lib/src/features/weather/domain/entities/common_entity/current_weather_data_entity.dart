// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'weather_condition_data_entity.dart';

class CurrentWeatherDataEntity extends Equatable {
  final DateTime last_updated;
  final double temp_c;
  final double feelsLike_c;
  final WeatherConditionDataEntity weatherConditionDataEntity;
  final double wind_kph;
  final int humidity;
  final double uv;

  const CurrentWeatherDataEntity({
    required this.last_updated,
    required this.temp_c,
    required this.feelsLike_c,
    required this.weatherConditionDataEntity,
    required this.wind_kph,
    required this.humidity,
    required this.uv,
  });

  @override
  List<Object?> get props => [
        last_updated,
        temp_c,
        feelsLike_c,
        weatherConditionDataEntity,
        wind_kph,
        humidity,
        uv,
      ];
}
