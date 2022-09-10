import 'package:weather_app/src/features/weather/data/models/forecast_models/forecast_weather_data_model.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';

import 'common_models/current_weather_data_model.dart';
import 'common_models/location_data_model.dart';

class ForecastWeatherModel extends ForecastWeatherEntity {
  static const _forecastWeatherDataKey = 'forecast';
  static const _currentWeatherDataKey = 'current';
  static const _locationDataKey = 'location';

  const ForecastWeatherModel({
    required String inputName,
    required LocationDataModel locationDataModel,
    required CurrentWeatherDataModel currentWeatherDataModel,
    required ForecastWeatherDataModel forecastWeatherDataModel,
  }) : super(
          inputName: inputName,
          locationDataEntity: locationDataModel,
          currentWeatherDataEntity: currentWeatherDataModel,
          forecastWeatherDataEntity: forecastWeatherDataModel,
        );

  Map<String, dynamic> toJson() {
    return {
      _locationDataKey: locationDataEntity,
      _currentWeatherDataKey: currentWeatherDataEntity,
      _forecastWeatherDataKey: forecastWeatherDataEntity
    };
  }

  factory ForecastWeatherModel.fromJson(
      String location, Map<String, dynamic> json) {
    return ForecastWeatherModel(
      inputName: location,
      locationDataModel: LocationDataModel.fromJson(
        json[_locationDataKey],
      ),
      currentWeatherDataModel: CurrentWeatherDataModel.fromJson(
        json[_currentWeatherDataKey],
      ),
      forecastWeatherDataModel: ForecastWeatherDataModel.fromMap(
        json[_forecastWeatherDataKey],
      ),
    );
  }
}
