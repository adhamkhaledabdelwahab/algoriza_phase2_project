import 'package:get_it/get_it.dart';
import 'package:weather_app/src/core/http/http.dart';
import 'package:weather_app/src/core/network_info/network_info.dart';
import 'package:weather_app/src/core/shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/features/weather/data/data_sources/data_sources.dart';
import 'package:weather_app/src/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/src/features/weather/domain/use_cases/use_cases.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/bloc/weather_cubit/weather_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  /// UI
  serviceLocator.registerFactory(
    () => WeatherCubit(
      getFetchFavouriteLocationForecast: serviceLocator(),
      getFetchOtherLocationsForecast: serviceLocator(),
      getFactoryReset: serviceLocator(),
      getRemoveSingleOtherLocation: serviceLocator(),
      getUpdateFavouriteLocationsForecast: serviceLocator(),
      getFetchSingleOtherLocationForecast: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationCubit(
      getUpdateOtherLocations: serviceLocator(),
      getFetchDeviceLocation: serviceLocator(),
      getFetchSingleOtherLocationForecast: serviceLocator(),
    ),
  );

  /// use cases
  serviceLocator.registerLazySingleton(
    () => GetFetchFavouriteLocationForecast(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchOtherLocationsForecast(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFactoryReset(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetRemoveSingleOtherLocation(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetUpdateFavouriteLocationsForecast(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchDeviceLocation(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetUpdateOtherLocations(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchSingleOtherLocationForecast(
      repository: serviceLocator(),
    ),
  );

  /// repository
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      localDataSource: serviceLocator(),
      remoteDataSource: serviceLocator(),
      locationDataSource: serviceLocator(),
    ),
  );

  /// data sources
  serviceLocator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      service: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      networkService: serviceLocator(),
      httpService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(),
  );

  /// services
  serviceLocator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesServiceImpl(
      provider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<HttpService>(
    () => HttpServiceImpl(
      provider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(
      networkProvider: serviceLocator(),
    ),
  );

  /// services providers
  serviceLocator.registerLazySingleton<SharedPreferencesProvider>(
    () => SharedPreferencesProvider.instance,
  );
  serviceLocator.registerLazySingleton<NetworkProvider>(
    () => NetworkProvider.instance,
  );
  serviceLocator.registerLazySingleton<HttpProvider>(
    () => HttpProvider.instance,
  );
}
