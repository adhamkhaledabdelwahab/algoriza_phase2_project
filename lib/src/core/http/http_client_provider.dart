import 'package:http/http.dart' as http;

class HttpProvider {
  static final _instance = HttpProvider._internal();
  bool isInitialized = false;
  late http.Client _client;

  static get instance => _instance;

  HttpProvider._internal();

  http.Client get() {
    if (!isInitialized) init();
    return _client;
  }

  void init() {
    _client = http.Client();
    isInitialized = true;
  }
}
