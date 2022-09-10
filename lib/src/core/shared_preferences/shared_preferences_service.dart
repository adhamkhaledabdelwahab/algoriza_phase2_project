abstract class SharedPreferencesService {
  Future<void> initSharedPreferencesService();

  Future<bool> containsKey({
    required String key,
  });

  Future<String?> getStringValue({
    required String key,
  });

  Future<bool> saveStringValue({
    required String key,
    required String value,
  });

  Future<List<String>?> getStringListValue({
    required String key,
  });

  Future<bool> saveStringListValue({
    required String key,
    required List<String> value,
  });

  Future<bool> cleanPreferenceStorage();
}
