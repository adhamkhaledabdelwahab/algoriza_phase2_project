import 'package:weather_app/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, void>> updateOtherLocations({
    required String location,
  });

  Future<Either<Failure, ForecastWeatherEntity>>
      updateFavouriteLocationForecastWeather({
    required String location,
  });

  Future<Either<Failure, ForecastWeatherEntity>>
      fetchFavouriteLocationForecastWeather();

  Future<Either<Failure, List<ForecastWeatherEntity>>>
      fetchOtherLocationsForecastWeather();

  Future<Either<Failure, ForecastWeatherEntity>>
      fetchSingleOtherLocationForecastWeather({
    required String location,
  });

  Future<Either<Failure, void>> removeSingleOtherLocation({
    required String location,
  });

  Future<Either<Failure, void>> factoryReset();

  Future<Either<Failure, String>> fetchDeviceLocation();
}
