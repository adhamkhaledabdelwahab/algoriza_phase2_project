import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:weather_app/src/features/weather/domain/repositories/weather_repository.dart';

class GetUpdateFavouriteLocationsForecast
    extends UseCase<ForecastWeatherEntity, String> {
  final WeatherRepository repository;

  GetUpdateFavouriteLocationsForecast({
    required this.repository,
  });

  @override
  Future<Either<Failure, ForecastWeatherEntity>> call(String params) async {
    return await repository.updateFavouriteLocationForecastWeather(
      location: params,
    );
  }
}
