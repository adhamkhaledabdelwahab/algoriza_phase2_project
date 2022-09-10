import 'package:weather_app/src/core/shared_preferences/shared_preferences_service.dart';
import 'package:weather_app/src/core/shared_preferences/shared_preferences_provider.dart';

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  late final SharedPreferencesProvider _provider;

  SharedPreferencesServiceImpl({
    required SharedPreferencesProvider provider,
  }) : _provider = provider;

  @override
  Future<void> initSharedPreferencesService() async => await _provider.init();

  @override
  Future<bool> containsKey({
    required String key,
  }) async {
    final prefs = await _provider.get();
    return prefs.containsKey(key);
  }

  @override
  Future<List<String>?> getStringListValue({
    required String key,
  }) async {
    final prefs = await _provider.get();
    return prefs.getStringList(key);
  }

  @override
  Future<String?> getStringValue({
    required String key,
  }) async {
    final prefs = await _provider.get();
    return prefs.getString(key);
  }

  @override
  Future<bool> saveStringListValue({
    required String key,
    required List<String> value,
  }) async {
    final prefs = await _provider.get();
    return await prefs.setStringList(key, value);
  }

  @override
  Future<bool> saveStringValue({
    required String key,
    required String value,
  }) async {
    final prefs = await _provider.get();
    return await prefs.setString(key, value);
  }

  @override
  Future<bool> cleanPreferenceStorage() async {
    final prefs = await _provider.get();
    return await prefs.clear();
  }
}
