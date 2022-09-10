// ignore_for_file: equal_keys_in_map

import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/day_forecast_data_entity.dart';

import 'forecast_astro_data_model.dart';
import 'forecast_day_data_model.dart';
import 'forecast_hour_data_model.dart';

class DayForecastDataModel extends DayForecastDataEntity {
  static const _dateKey = 'date_epoch';
  static const _forecastDayDataKey = 'day';
  static const _forecastAstroDataKey = 'astro';
  static const _forecastHourDatasKey = 'hour';

  const DayForecastDataModel({
    required DateTime date,
    required ForecastDayDataModel forecastDayDataModel,
    required ForecastAstroDataModel forecastAstroDataModel,
    required List<ForecastHourDataModel> forecastHourDataModels,
  }) : super(
          date: date,
          forecastHourDataEntities: forecastHourDataModels,
          forecastAstroDataEntity: forecastAstroDataModel,
          forecastDayDataEntity: forecastDayDataModel,
        );

  Map<String, dynamic> toJson() {
    return {
      _dateKey: date,
      _forecastDayDataKey: forecastDayDataEntity,
      _forecastAstroDataKey: forecastAstroDataEntity,
      _forecastHourDatasKey: forecastHourDataEntities,
    };
  }

  factory DayForecastDataModel.fromJson(Map<String, dynamic> json) {
    final list = json[_forecastHourDatasKey] as List<dynamic>;
    final result = <ForecastHourDataModel>[];
    for (int i = 0; i < list.length; i++) {
      final model = ForecastHourDataModel.fromJson(list[i]);
      result.add(model);
    }
    return DayForecastDataModel(
      date: DateTime.fromMillisecondsSinceEpoch(json[_dateKey] * 1000),
      forecastDayDataModel: ForecastDayDataModel.fromJson(
        json[_forecastDayDataKey],
      ),
      forecastAstroDataModel: ForecastAstroDataModel.fromJson(
        json[_forecastAstroDataKey],
      ),
      forecastHourDataModels: result,
    );
  }
}
