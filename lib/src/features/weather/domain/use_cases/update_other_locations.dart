import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';
import 'package:weather_app/src/features/weather/domain/repositories/weather_repository.dart';

class GetUpdateOtherLocations extends UseCase<void, String> {
  final WeatherRepository repository;

  GetUpdateOtherLocations({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.updateOtherLocations(location: params);
  }
}
