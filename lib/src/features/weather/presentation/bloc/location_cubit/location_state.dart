part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitialState extends LocationState {}

class LocationPageInitializingState extends LocationState {}

class LocationPageInitializedState extends LocationState {}

class LocationPageInitializingErrorState extends LocationState {
  final String errMessage;

  LocationPageInitializingErrorState(this.errMessage);
}

class InputLocationValidatingState extends LocationState {}

class InputLocationValidatedState extends LocationState {}

class InputLocationValidatingErrorState extends LocationState {
  final String errMessage;

  InputLocationValidatingErrorState(this.errMessage);
}

class LocationTypeUpdatingState extends LocationState {}

class LocationTypeUpdatedState extends LocationState {}

class LocationTypeUpdatingErrorState extends LocationState {
  final String errMessage;

  LocationTypeUpdatingErrorState(this.errMessage);
}

class LocationOtherLocationsUpdatingState extends LocationState {}

class LocationOtherLocationsUpdatedState extends LocationState {}

class LocationOtherLocationsUpdatingErrorState extends LocationState {
  final String errMessage;

  LocationOtherLocationsUpdatingErrorState(this.errMessage);
}

class DeviceLocationFetchingState extends LocationState {}

class DeviceLocationFetchedState extends LocationState {}

class DeviceLocationFetchingErrorState extends LocationState {
  final String errMessage;

  DeviceLocationFetchingErrorState(this.errMessage);
}

class LocationTypeFormValidatingState extends LocationState {}

class LocationTypeFormValidatedState extends LocationState {}

class LocationTypeFormValidatingErrorState extends LocationState {
  final String errMessage;

  LocationTypeFormValidatingErrorState(this.errMessage);
}
