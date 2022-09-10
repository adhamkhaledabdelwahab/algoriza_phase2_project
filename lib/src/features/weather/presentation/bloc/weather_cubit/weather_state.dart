part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class AppForecastWeathersFetchingState extends WeatherState {}

class AppForecastWeathersFetchedState extends WeatherState {}

class AppForecastWeathersFetchingErrorState extends WeatherState {
  final String errMessage;

  AppForecastWeathersFetchingErrorState(this.errMessage);
}

class AppFactoryResetingState extends WeatherState {}

class AppFactoryResetedState extends WeatherState {}

class AppFactoryResetingErrorState extends WeatherState {
  final String errMessage;

  AppFactoryResetingErrorState(this.errMessage);
}

class SingleOtherLocationRemovingState extends WeatherState {}

class SingleOtherLocationRemovedState extends WeatherState {}

class SingleOtherLocationRemovingErrorState extends WeatherState {
  final String errMessage;

  SingleOtherLocationRemovingErrorState(this.errMessage);
}

class WeatherFavouriteLocationUpdatingState extends WeatherState {}

class WeatherFavouriteLocationUpdatedState extends WeatherState {}

class WeatherFavouriteLocationUpdatingErrorState extends WeatherState {
  final String errMessage;

  WeatherFavouriteLocationUpdatingErrorState(this.errMessage);
}

class OtherLocationsUpdatingState extends WeatherState {}

class OtherLocationsUpdatedState extends WeatherState {}

class OtherLocationsUpdatingErrorState extends WeatherState {
  final String errMessage;

  OtherLocationsUpdatingErrorState(this.errMessage);
}

class AppThemeModeUpdatingState extends WeatherState {}

class AppThemeModeUpdatedState extends WeatherState {}

class AppThemeModeUpdatingErrorState extends WeatherState {
  final String errMessage;

  AppThemeModeUpdatingErrorState(this.errMessage);
}
