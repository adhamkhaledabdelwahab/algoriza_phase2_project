import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';

import '../repositories/weather_repository.dart';

class GetRemoveSingleOtherLocation extends UseCase<void, String> {
  final WeatherRepository repository;

  GetRemoveSingleOtherLocation({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.removeSingleOtherLocation(location: params);
  }
}
