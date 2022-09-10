// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import '../common_entity/weather_condition_data_entity.dart';

class ForecastDayDataEntity extends Equatable {
  final double maxTemp_c;
  final double minTemp_c;
  final double avgTemp_c;
  final double maxWind_kph;
  final int avgHumidity;
  final WeatherConditionDataEntity weatherConditionDataEntity;
  final double uv;

  const ForecastDayDataEntity({
    required this.maxTemp_c,
    required this.minTemp_c,
    required this.avgTemp_c,
    required this.maxWind_kph,
    required this.avgHumidity,
    required this.weatherConditionDataEntity,
    required this.uv,
  });

  @override
  List<Object?> get props => [
        maxTemp_c,
        minTemp_c,
        avgTemp_c,
        maxWind_kph,
        avgHumidity,
        weatherConditionDataEntity,
        uv,
      ];
}
