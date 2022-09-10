import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';

import '../entities/forecast_weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetFetchOtherLocationsForecast
    extends UseCase<List<ForecastWeatherEntity>, NoParams> {
  final WeatherRepository repository;

  GetFetchOtherLocationsForecast({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ForecastWeatherEntity>>> call(
      NoParams params) async {
    return await repository.fetchOtherLocationsForecastWeather();
  }
}
