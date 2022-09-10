// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import '../common_entity/weather_condition_data_entity.dart';

class ForecastHourDataEntity extends Equatable {
  final DateTime time;
  final int humidity;
  final double temp_c;
  final WeatherConditionDataEntity weatherConditionDataEntity;

  const ForecastHourDataEntity({
    required this.time,
    required this.humidity,
    required this.temp_c,
    required this.weatherConditionDataEntity,
  });

  @override
  List<Object?> get props => [
        time,
        humidity,
        temp_c,
        weatherConditionDataEntity,
      ];
}
