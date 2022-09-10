import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';
import 'package:weather_app/src/features/weather/domain/repositories/weather_repository.dart';

class GetFetchDeviceLocation extends UseCase<String, NoParams> {
  final WeatherRepository repository;

  GetFetchDeviceLocation({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.fetchDeviceLocation();
  }
}
