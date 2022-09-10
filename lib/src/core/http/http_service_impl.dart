import 'package:http/http.dart';
import 'package:weather_app/src/core/http/http_client_provider.dart';
import 'package:weather_app/src/core/http/http_service.dart';

class HttpServiceImpl implements HttpService {
  late final HttpProvider _provider;

  HttpServiceImpl({
    required HttpProvider provider,
  }) : _provider = provider;

  @override
  void initHttpService() => _provider.init();

  @override
  Future<Response> get({required Uri uri}) async {
    final client = _provider.get();
    return await client.get(uri);
  }
}
