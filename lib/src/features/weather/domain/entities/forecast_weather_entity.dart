import 'package:equatable/equatable.dart';

import 'common_entity/current_weather_data_entity.dart';
import 'common_entity/location_data_entity.dart';
import 'forecast_entities/forecast_weather_data_entity.dart';

class ForecastWeatherEntity extends Equatable {
  final String inputName;
  final LocationDataEntity locationDataEntity;
  final CurrentWeatherDataEntity currentWeatherDataEntity;
  final ForecastWeatherDataEntity forecastWeatherDataEntity;

  const ForecastWeatherEntity({
    required this.inputName,
    required this.locationDataEntity,
    required this.currentWeatherDataEntity,
    required this.forecastWeatherDataEntity,
  });

  @override
  List<Object> get props => [
        inputName,
        locationDataEntity,
        currentWeatherDataEntity,
        forecastWeatherDataEntity,
      ];
}
