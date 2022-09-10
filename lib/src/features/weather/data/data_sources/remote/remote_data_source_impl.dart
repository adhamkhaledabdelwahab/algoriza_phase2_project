import 'dart:convert';

import 'package:weather_app/src/core/constants/http_consts.dart';
import 'package:weather_app/src/core/errors/exceptions.dart';
import 'package:weather_app/src/core/http/http.dart';
import 'package:weather_app/src/core/network_info/network_info.dart';
import 'package:weather_app/src/core/utils/http_util.dart';
import 'package:weather_app/src/features/weather/data/data_sources/remote/remote_data_source.dart';
import 'package:weather_app/src/features/weather/data/models/forecast_weather_model.dart';
import 'package:weather_app/src/features/weather/data/models/history_weather_model.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/day_forecast_data_entity.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_entities/forecast_weather_data_entity.dart';
import 'package:weather_app/src/features/weather/domain/entities/forecast_weather_entity.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;
  final HttpService httpService;

  const RemoteDataSourceImpl({
    required this.networkService,
    required this.httpService,
  });

  @override
  Future<ForecastWeatherEntity> fetchCurrentForecastWeather({
    required String location,
  }) async {
    try {
      final isConnected = await networkService.isConnected;
      if (isConnected) {
        return await _fetchDayForecast(
          location,
          '1',
        );
      } else {
        throw NetworkException(errMsg: "Network is Off!");
      }
    } on NetworkException catch (e) {
      throw NetworkException(errMsg: "$e");
    } catch (e) {
      throw ServerException(errMsg: '$e');
    }
  }

  Future<ForecastWeatherEntity> _fetchDayForecast(
    String location,
    String days,
  ) async {
    final forecastUri = fetchRequiredUri(
      location: location,
      weatherType: forecastWeatherType,
      daysNumber: days,
    );
    final forecastResponse = await httpService.get(uri: forecastUri);
    if (forecastResponse.statusCode == 200) {
      final body = jsonDecode(forecastResponse.body);
      final forecastWeather = ForecastWeatherModel.fromJson(location, body);
      return forecastWeather;
    } else {
      throw ServerException(
          errMsg: jsonDecode(forecastResponse.body)['message']);
    }
  }

  @override
  Future<ForecastWeatherEntity> fetchWeekForecastWeather({
    required String location,
  }) async {
    try {
      final isConnected = await networkService.isConnected;
      if (isConnected) {
        final weekForecastWeather = _fetchResultWeekForecastWeather(
          location,
        );
        return weekForecastWeather;
      } else {
        throw NetworkException(errMsg: "Network is Off!");
      }
    } catch (e) {
      throw ServerException(errMsg: '$e');
    }
  }

  Future<ForecastWeatherEntity> _fetchResultWeekForecastWeather(
    String location,
  ) async {
    DayForecastDataEntity prevDays = await _fetchSingleDayHistory(
      location,
    );
    final fetchedForecastWeather = await _fetchDayForecast(
      location,
      "7",
    );
    final resultForecastWeather = ForecastWeatherEntity(
      inputName: location,
      locationDataEntity: fetchedForecastWeather.locationDataEntity,
      currentWeatherDataEntity: fetchedForecastWeather.currentWeatherDataEntity,
      forecastWeatherDataEntity: ForecastWeatherDataEntity(
        dayForecastDataEntities: [
          prevDays,
          ...fetchedForecastWeather
              .forecastWeatherDataEntity.dayForecastDataEntities
        ],
      ),
    );
    return resultForecastWeather;
  }

  Future<DayForecastDataEntity> _fetchSingleDayHistory(
    String location,
  ) async {
    final DateTime now = DateTime.now().subtract(
      const Duration(days: 1),
    );
    final year = now.year;
    final month = now.month;
    final day = now.day;
    final historyUri = fetchRequiredUri(
      location: location,
      weatherType: historyWeatherType,
      date: "$year-$month-$day",
    );

    final historyResponse = await httpService.get(uri: historyUri);
    if (historyResponse.statusCode == 200) {
      final body = jsonDecode(historyResponse.body);
      final historyWeather = HistoryWeatherModel.fromJson(body);
      return historyWeather
          .forecastWeatherDataEntity.dayForecastDataEntities[0];
    } else {
      throw ServerException(
          errMsg: jsonDecode(historyResponse.body)['error']['message']);
    }
  }
}
