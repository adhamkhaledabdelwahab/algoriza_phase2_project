import 'package:equatable/equatable.dart';

import 'day_forecast_data_entity.dart';

class ForecastWeatherDataEntity extends Equatable {
  final List<DayForecastDataEntity> dayForecastDataEntities;

  const ForecastWeatherDataEntity({
    required this.dayForecastDataEntities,
  });

  @override
  List<Object> get props => [
        dayForecastDataEntities,
      ];
}
