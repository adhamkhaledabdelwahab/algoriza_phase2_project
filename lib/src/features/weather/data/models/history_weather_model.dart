// ignore_for_file: equal_keys_in_map

import 'package:weather_app/src/features/weather/data/models/common_models/location_data_model.dart';
import 'package:weather_app/src/features/weather/data/models/forecast_models/forecast_weather_data_model.dart';
import 'package:weather_app/src/features/weather/domain/entities/history_weather_entity.dart';

class HistoryWeatherModel extends HistoryWeatherEntity {
  static const _locationDataKey = 'location';
  static const _forecastWeatherDataKey = 'forecast';

  const HistoryWeatherModel({
    required LocationDataModel locationDataModel,
    required ForecastWeatherDataModel forecastWeatherDataModel,
  }) : super(
          locationDataEntity: locationDataModel,
          forecastWeatherDataEntity: forecastWeatherDataModel,
        );

  Map<String, dynamic> toJson() {
    return {
      _locationDataKey: _locationDataKey,
      _forecastWeatherDataKey: _forecastWeatherDataKey,
    };
  }

  factory HistoryWeatherModel.fromJson(Map<String, dynamic> json) {
    return HistoryWeatherModel(
      locationDataModel: LocationDataModel.fromJson(
        json[_locationDataKey],
      ),
      forecastWeatherDataModel: ForecastWeatherDataModel.fromMap(
        json[_forecastWeatherDataKey],
      ),
    );
  }
}
