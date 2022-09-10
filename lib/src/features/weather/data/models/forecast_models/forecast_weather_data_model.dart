import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/forecast_weather_data_entity.dart';

import 'day_forecast_data_model.dart';

class ForecastWeatherDataModel extends ForecastWeatherDataEntity {
  static const _dayForecastDataKey = 'forecastday';

  const ForecastWeatherDataModel({
    required List<DayForecastDataModel> dayForecastDataModels,
  }) : super(dayForecastDataEntities: dayForecastDataModels);

  Map<String, dynamic> toMap() {
    return {
      _dayForecastDataKey: dayForecastDataEntities,
    };
  }

  factory ForecastWeatherDataModel.fromMap(Map<String, dynamic> json) {
    final List<dynamic> list = json[_dayForecastDataKey];
    final result = <DayForecastDataModel>[];
    for (int i = 0; i < list.length; i++) {
      final model = DayForecastDataModel.fromJson(list[i]);
      result.add(model);
    }
    return ForecastWeatherDataModel(
      dayForecastDataModels: result,
    );
  }
}
