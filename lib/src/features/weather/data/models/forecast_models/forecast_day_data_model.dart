// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/forecast_day_data_entity.dart';

import '../common_models/weather_condition_data_model.dart';

class ForecastDayDataModel extends ForecastDayDataEntity {
  static const String _maxTemp_cKey = 'maxtemp_c';
  static const String _minTemp_cKey = 'mintemp_c';
  static const String _avgTemp_cKey = 'avgtemp_c';
  static const String _maxWind_kphKey = 'maxwind_kph';
  static const String _avgHumidityKey = 'avghumidity';
  static const String _weatherConditionDataKey = 'condition';
  static const String _uvKey = 'uv';

  const ForecastDayDataModel({
    required double maxTemp_c,
    required double minTemp_c,
    required double avgTemp_c,
    required double maxWind_kph,
    required int avgHumidity,
    required WeatherConditionDataModel weatherConditionDataModel,
    required double uv,
  }) : super(
          maxTemp_c: maxTemp_c,
          minTemp_c: minTemp_c,
          avgTemp_c: avgTemp_c,
          maxWind_kph: maxWind_kph,
          avgHumidity: avgHumidity,
          weatherConditionDataEntity: weatherConditionDataModel,
          uv: uv,
        );

  Map<String, dynamic> toJson() {
    return {
      _maxTemp_cKey: maxTemp_c,
      _minTemp_cKey: minTemp_c,
      _avgTemp_cKey: avgTemp_c,
      _maxWind_kphKey: maxWind_kph,
      _avgHumidityKey: avgHumidity,
      _weatherConditionDataKey: weatherConditionDataEntity,
      _uvKey: uv,
    };
  }

  factory ForecastDayDataModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayDataModel(
      maxTemp_c: json[_maxTemp_cKey],
      minTemp_c: json[_minTemp_cKey],
      avgTemp_c: json[_avgTemp_cKey],
      maxWind_kph: json[_maxWind_kphKey],
      avgHumidity: (json[_avgHumidityKey] as double).toInt(),
      weatherConditionDataModel: WeatherConditionDataModel.fromJson(
        json[_weatherConditionDataKey],
      ),
      uv: json[_uvKey],
    );
  }
}
