// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/forecast_hour_data_entity.dart';

import '../common_models/weather_condition_data_model.dart';

class ForecastHourDataModel extends ForecastHourDataEntity {
  static const String _timeKey = 'time_epoch';
  static const String _humidityKey = 'humidity';
  static const String _temp_cKey = 'temp_c';
  static const String _weatherConditionDataKey = 'condition';

  const ForecastHourDataModel({
    required DateTime time,
    required int humidity,
    required double temp_c,
    required WeatherConditionDataModel weatherConditionDataModel,
  }) : super(
          time: time,
          humidity: humidity,
          temp_c: temp_c,
          weatherConditionDataEntity: weatherConditionDataModel,
        );

  Map<String, dynamic> toJson() {
    return {
      _timeKey: time,
      _humidityKey: humidity,
      _temp_cKey: temp_c,
      _weatherConditionDataKey: weatherConditionDataEntity,
    };
  }

  factory ForecastHourDataModel.fromJson(Map<String, dynamic> json) {
    return ForecastHourDataModel(
      time: DateTime.fromMillisecondsSinceEpoch(json[_timeKey] * 1000),
      humidity: json[_humidityKey],
      temp_c: json[_temp_cKey],
      weatherConditionDataModel: WeatherConditionDataModel.fromJson(
        json[_weatherConditionDataKey],
      ),
    );
  }
}
