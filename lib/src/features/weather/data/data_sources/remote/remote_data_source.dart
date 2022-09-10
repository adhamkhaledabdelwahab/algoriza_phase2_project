import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';

abstract class RemoteDataSource {
  Future<ForecastWeatherEntity> fetchCurrentForecastWeather({
    required String location,
  });

  Future<ForecastWeatherEntity> fetchWeekForecastWeather({
    required String location,
  });
}
