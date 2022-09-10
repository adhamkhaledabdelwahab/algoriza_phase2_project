import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/errors/exceptions.dart';
import 'package:weather_app/src/core/user_cases/usecase.dart';
import 'package:weather_app/src/features/weather/domain/use_cases/use_cases.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/location_page_widgets/device_location_widget.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/location_page_widgets/location_coordinates_widget.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/location_page_widgets/location_name_widget.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  late final GetFetchSingleOtherLocationForecast
      _getFetchSingleOtherLocationForecast;
  late final GetUpdateOtherLocations _getUpdateOtherLocations;
  late final GetFetchDeviceLocation _getFetchDeviceLocation;
  TextEditingController? latController;
  TextEditingController? lonController;
  TextEditingController? nameController;
  String? selectedLocationType;
  String? validatedLocation;

  static const Map<String, Widget> locationTypes = {
    'Device Location': DeviceLocationWidget(),
    'Location coordinates': LocationCoordinatesWidget(),
    'Location Name': LocationNameWidget(),
  };

  LocationCubit({
    required GetFetchSingleOtherLocationForecast
        getFetchSingleOtherLocationForecast,
    required GetUpdateOtherLocations getUpdateOtherLocations,
    required GetFetchDeviceLocation getFetchDeviceLocation,
  }) : super(
          LocationInitialState(),
        ) {
    _getFetchSingleOtherLocationForecast = getFetchSingleOtherLocationForecast;
    _getUpdateOtherLocations = getUpdateOtherLocations;
    _getFetchDeviceLocation = getFetchDeviceLocation;
  }

  static LocationCubit get(BuildContext context) => BlocProvider.of(context);

  _updateState(LocationState state) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state);
  }

  Future<void> initializeLocationPage() async {
    await _updateState(LocationPageInitializingState());
    try {
      latController = TextEditingController();
      lonController = TextEditingController();
      nameController = TextEditingController();
      selectedLocationType = locationTypes.keys.first;
      await _updateState(LocationPageInitializedState());
    } catch (e) {
      await _updateState(LocationPageInitializingErrorState('$e'));
    }
  }

  Future<void> validateLocation() async {
    await _updateState(InputLocationValidatingState());
    final result =
        await _getFetchSingleOtherLocationForecast.call(validatedLocation!);
    await result.fold((fail) async {
      await _updateState(InputLocationValidatingErrorState(fail.errMessage));
    }, (entity) async {
      await _updateState(InputLocationValidatedState());
    });
  }

  Future<void> updateSelectedLocationType(String key) async {
    await _updateState(LocationTypeUpdatingState());
    try {
      selectedLocationType = key;
      await _updateState(LocationTypeUpdatedState());
    } catch (e) {
      await _updateState(LocationTypeUpdatingErrorState('$e'));
    }
  }

  Future<void> updateFavouriteLocation() async {
    await _updateState(LocationOtherLocationsUpdatingState());
    final result = await _getUpdateOtherLocations.call(validatedLocation!);
    await result.fold(
      (fail) async {
        await _updateState(
          LocationOtherLocationsUpdatingErrorState(
            fail.errMessage,
          ),
        );
      },
      (voidR) async {
        await _updateState(LocationOtherLocationsUpdatedState());
      },
    );
  }

  Future<void> validateLocationTypeForm() async {
    await _updateState(LocationTypeFormValidatingState());
    try {
      final coordinateType = locationTypes.keys.toList()[1];
      final nameType = locationTypes.keys.toList()[2];
      if (selectedLocationType == coordinateType) {
        if (latController!.text.isEmpty) {
          throw UnKnownException(errMsg: 'Location Latitude required!');
        } else if (lonController!.text.isEmpty) {
          throw UnKnownException(errMsg: 'Location Longitude required!');
        } else {
          final lat = double.tryParse(latController!.text);
          final lon = double.tryParse(lonController!.text);
          if (lat == null) {
            throw UnKnownException(errMsg: 'Invalid Location Latitude!');
          } else if (lon == null) {
            throw UnKnownException(errMsg: 'Invalid Location Longitude!');
          } else {
            validatedLocation = '$lat,$lon';
          }
        }
      } else if (selectedLocationType == nameType) {
        if (nameController!.text.isEmpty) {
          throw UnKnownException(errMsg: 'Location Name required!');
        } else {
          validatedLocation = nameController!.text;
        }
      }
      await _updateState(LocationTypeFormValidatedState());
    } on UnKnownException catch (e) {
      await _updateState(LocationTypeFormValidatingErrorState(e.errMsg));
    }
  }

  Future<void> getCurrentLocation() async {
    await _updateState(DeviceLocationFetchingState());
    final result = await _getFetchDeviceLocation.call(NoParams());
    await result.fold(
      (fail) async {
        await _updateState(DeviceLocationFetchingErrorState(fail.errMessage));
      },
      (path) async {
        validatedLocation = path;
        await _updateState(DeviceLocationFetchedState());
      },
    );
  }
}
