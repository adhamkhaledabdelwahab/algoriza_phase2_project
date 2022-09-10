import 'package:dartz/dartz.dart';
import 'package:weather_app/src/core/errors/exceptions.dart';
import 'package:weather_app/src/core/errors/failures.dart';
import 'package:weather_app/src/features/weather/data/data_sources/data_sources.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:weather_app/src/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final LocationDataSource locationDataSource;

  const WeatherRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.locationDataSource,
  });

  @override
  Future<Either<Failure, ForecastWeatherEntity>>
      fetchFavouriteLocationForecastWeather() async {
    try {
      final location = await localDataSource.fetchFavouriteLocation();
      if (location == null) {
        throw UnKnownException(errMsg: 'Favourite Location Name is null!');
      }
      final result = await remoteDataSource.fetchWeekForecastWeather(
        location: location,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkConnectionFailure());
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ForecastWeatherEntity>>>
      fetchOtherLocationsForecastWeather() async {
    try {
      final result = <ForecastWeatherEntity>[];
      final locations = await localDataSource.fetchOtherLocations();
      if (locations == null) {
        throw UnKnownException(errMsg: 'Other Locations is null');
      }
      for (int i = 0; i < locations.length; i++) {
        final locResult = await remoteDataSource.fetchCurrentForecastWeather(
          location: locations[i],
        );
        result.add(locResult);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkConnectionFailure());
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> factoryReset() async {
    try {
      return Right(await localDataSource.cleanStorage());
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeSingleOtherLocation({
    required String location,
  }) async {
    try {
      return Right(await localDataSource.removeSingleOtherLocation(
        location: location,
      ));
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> fetchDeviceLocation() async {
    try {
      await locationDataSource.requestPermission();
      final position = await locationDataSource.fetchDevicePosition();
      final location = '${position.latitude},${position.longitude}';
      return Right(location);
    } on LocationException {
      return Left(LocationFailure());
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateOtherLocations({
    required String location,
  }) async {
    try {
      return Right(
        await _updateOtherLocations(location),
      );
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  Future<void> _updateOtherLocations(String location) async {
    final fav = await localDataSource.fetchFavouriteLocation();
    if (fav == null) {
      await localDataSource.updateFavouriteLocation(
        location: location,
      );
    }
    return await localDataSource.updateOtherLocations(
      location: location,
    );
  }

  @override
  Future<Either<Failure, ForecastWeatherEntity>>
      updateFavouriteLocationForecastWeather({
    required String location,
  }) async {
    try {
      await localDataSource.updateFavouriteLocation(location: location);
      final result = await remoteDataSource.fetchWeekForecastWeather(
        location: location,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkConnectionFailure());
    } on UnKnownException {
      return Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, ForecastWeatherEntity>>
      fetchSingleOtherLocationForecastWeather({
    required String location,
  }) async {
    try {
      final locResult = await remoteDataSource.fetchCurrentForecastWeather(
        location: location,
      );
      return Right(locResult);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkConnectionFailure());
    }
  }
}
