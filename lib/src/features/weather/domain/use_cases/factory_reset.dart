import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';

import '../repositories/weather_repository.dart';

class GetFactoryReset extends UseCase<void, NoParams> {
  final WeatherRepository repository;

  GetFactoryReset({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.factoryReset();
  }
}
