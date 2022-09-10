import 'package:equatable/equatable.dart';

import 'common_entity/location_data_entity.dart';
import 'forecast_entities/forecast_weather_data_entity.dart';

class HistoryWeatherEntity extends Equatable {
  final LocationDataEntity locationDataEntity;
  final ForecastWeatherDataEntity forecastWeatherDataEntity;

  const HistoryWeatherEntity({
    required this.locationDataEntity,
    required this.forecastWeatherDataEntity,
  });

  @override
  List<Object> get props => [
        locationDataEntity,
        forecastWeatherDataEntity,
      ];
}
