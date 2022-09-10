import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:weather_app/src/features/weather/domain/use_cases/use_cases.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  late final GetFetchFavouriteLocationForecast
      _getFetchFavouriteLocationForecast;
  late final GetFetchOtherLocationsForecast _getFetchOtherLocationsForecast;
  late final GetFactoryReset _getFactoryReset;
  late final GetRemoveSingleOtherLocation _getRemoveSingleOtherLocation;
  late final GetUpdateFavouriteLocationsForecast
      _getUpdateFavouriteLocationsForecast;
  late final GetFetchSingleOtherLocationForecast
      _getFetchSingleOtherLocationForecast;
  ThemeMode mode = ThemeMode.dark;
  ForecastWeatherEntity? currentForecast;
  List<ForecastWeatherEntity> otherForecasts = <ForecastWeatherEntity>[];

  WeatherCubit({
    required GetFetchFavouriteLocationForecast
        getFetchFavouriteLocationForecast,
    required GetFetchOtherLocationsForecast getFetchOtherLocationsForecast,
    required GetFactoryReset getFactoryReset,
    required GetRemoveSingleOtherLocation getRemoveSingleOtherLocation,
    required GetUpdateFavouriteLocationsForecast
        getUpdateFavouriteLocationsForecast,
    required GetFetchSingleOtherLocationForecast
        getFetchSingleOtherLocationForecast,
  }) : super(WeatherInitialState()) {
    _getFetchFavouriteLocationForecast = getFetchFavouriteLocationForecast;
    _getFetchOtherLocationsForecast = getFetchOtherLocationsForecast;
    _getFactoryReset = getFactoryReset;
    _getRemoveSingleOtherLocation = getRemoveSingleOtherLocation;
    _getUpdateFavouriteLocationsForecast = getUpdateFavouriteLocationsForecast;
    _getFetchSingleOtherLocationForecast = getFetchSingleOtherLocationForecast;
  }

  Future<void> toggleThemeMode() async {
    await _updateState(AppThemeModeUpdatingState());
    try {
      mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      await _updateState(AppThemeModeUpdatedState());
    } catch (e) {
      await _updateState(AppThemeModeUpdatingErrorState('$e'));
    }
  }

  static WeatherCubit get(BuildContext context) => BlocProvider.of(context);

  _updateState(WeatherState state) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state);
  }

  Future<void> fetchAppForecastWeathers() async {
    await _updateState(AppForecastWeathersFetchingState());
    final result = await _getFetchFavouriteLocationForecast.call(NoParams());
    await result.fold(
      (fail) async {
        await _updateState(
          AppForecastWeathersFetchingErrorState(
            fail.errMessage,
          ),
        );
      },
      (entity) async {
        currentForecast = entity;
        final result = await _getFetchOtherLocationsForecast.call(NoParams());
        await result.fold(
          (fail) async {
            await _updateState(
              AppForecastWeathersFetchingErrorState(
                fail.errMessage,
              ),
            );
          },
          (entities) async {
            otherForecasts.clear();
            otherForecasts.addAll(entities);
            await _updateState(AppForecastWeathersFetchedState());
          },
        );
      },
    );
  }

  Future<void> factoryReset() async {
    await _updateState(AppFactoryResetingState());
    final result = await _getFactoryReset.call(NoParams());
    await result.fold(
      (fail) async {
        await _updateState(
          AppFactoryResetingErrorState(
            fail.errMessage,
          ),
        );
      },
      (voidR) async {
        otherForecasts.clear();
        await _updateState(AppFactoryResetedState());
      },
    );
  }

  Future<void> removeSingleLocation(String location) async {
    await _updateState(SingleOtherLocationRemovingState());
    final result = await _getRemoveSingleOtherLocation.call(location);
    await result.fold(
      (fail) async {
        await _updateState(
          SingleOtherLocationRemovingErrorState(
            fail.errMessage,
          ),
        );
      },
      (voidR) async {
        otherForecasts.removeWhere(
          (element) => element.inputName == location,
        );
        await _updateState(SingleOtherLocationRemovedState());
      },
    );
  }

  Future<void> updateFavouriteLocation(String location) async {
    await _updateState(WeatherFavouriteLocationUpdatingState());
    final result = await _getUpdateFavouriteLocationsForecast.call(location);
    await result.fold(
      (fail) async {
        await _updateState(
          WeatherFavouriteLocationUpdatingErrorState(
            fail.errMessage,
          ),
        );
      },
      (entity) async {
        currentForecast = entity;
        await _updateState(WeatherFavouriteLocationUpdatedState());
      },
    );
  }

  Future<void> addNewOtherLocations(String location) async {
    await _updateState(OtherLocationsUpdatingState());
    final result = await _getFetchSingleOtherLocationForecast.call(location);
    await result.fold(
      (fail) async {
        await _updateState(
          OtherLocationsUpdatingErrorState(
            fail.errMessage,
          ),
        );
      },
      (entity) async {
        otherForecasts.add(entity);
        await _updateState(OtherLocationsUpdatedState());
      },
    );
  }
}
