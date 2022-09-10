import 'package:weather_app/src/core/constants/shared_preferences_keys.dart';
import 'package:weather_app/src/core/errors/exceptions.dart';
import 'package:weather_app/src/core/shared_preferences/shared_preferences.dart';

import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferencesService service;

  const LocalDataSourceImpl({
    required this.service,
  });

  @override
  Future<String?> fetchFavouriteLocation() async {
    try {
      final keyExists = await service.containsKey(key: favouriteLocation);
      if (keyExists) {
        final result = await service.getStringValue(key: favouriteLocation);
        return result;
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
    return null;
  }

  @override
  Future<List<String>?> fetchOtherLocations() async {
    try {
      final keyExists = await service.containsKey(key: otherLocations);
      if (keyExists) {
        final result = await service.getStringListValue(key: otherLocations);
        return result;
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
    return null;
  }

  @override
  Future<void> updateFavouriteLocation({
    required String location,
  }) async {
    try {
      final done = await service.saveStringValue(
        key: favouriteLocation,
        value: location,
      );
      if (!done) {
        throw UnKnownException(
            errMsg: "Error favourite location did not update!");
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
    return;
  }

  @override
  Future<void> updateOtherLocations({required String location}) async {
    try {
      final keyExists = await service.containsKey(key: otherLocations);
      final list = <String>[];
      if (keyExists) {
        final prefList = await service.getStringListValue(key: otherLocations);
        if (prefList != null) {
          if (prefList.contains(location)) {
            throw UnKnownException(errMsg: 'This location already exists!');
          }
          list.addAll(prefList);
        }
      }
      list.add(location);
      final done = await service.saveStringListValue(
        key: otherLocations,
        value: list,
      );
      if (!done) {
        throw UnKnownException(
            errMsg: "Error favourite location did not update!");
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
    return;
  }

  @override
  Future<void> cleanStorage() async {
    try {
      final result = await service.cleanPreferenceStorage();
      if (!result) {
        throw (UnKnownException(errMsg: 'Failed To Clear Storage!'));
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
  }

  @override
  Future<void> removeSingleOtherLocation({required String location}) async {
    try {
      final keyExists = await service.containsKey(key: otherLocations);
      if (keyExists) {
        final list = await service.getStringListValue(key: otherLocations);
        list!.contains(location)
            ? list.remove(location)
            : throw UnKnownException(
                errMsg: 'Wrong location!',
              );
        final done = await service.saveStringListValue(
          key: otherLocations,
          value: list,
        );
        if (!done) {
          throw UnKnownException(
              errMsg: "Error $location location did not remove!");
        }
        return;
      }
    } catch (e) {
      throw UnKnownException(errMsg: '$e');
    }
  }
}
