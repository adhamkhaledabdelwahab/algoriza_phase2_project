abstract class LocalDataSource {
  Future<String?> fetchFavouriteLocation();

  Future<void> updateFavouriteLocation({required String location});

  Future<void> updateOtherLocations({required String location});

  Future<List<String>?> fetchOtherLocations();

  Future<void> removeSingleOtherLocation({required String location});

  Future<void> cleanStorage();
}
