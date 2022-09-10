import 'package:equatable/equatable.dart';

import 'forecast_astro_data_entity.dart';
import 'forecast_day_data_entity.dart';
import 'forecast_hour_data_entity.dart';

class DayForecastDataEntity extends Equatable {
  final DateTime date;
  final ForecastDayDataEntity forecastDayDataEntity;
  final ForecastAstroDataEntity forecastAstroDataEntity;
  final List<ForecastHourDataEntity> forecastHourDataEntities;

  const DayForecastDataEntity({
    required this.date,
    required this.forecastDayDataEntity,
    required this.forecastAstroDataEntity,
    required this.forecastHourDataEntities,
  });

  @override
  List<Object> get props => [
        date,
        forecastDayDataEntity,
        forecastAstroDataEntity,
        forecastHourDataEntities,
      ];
}
