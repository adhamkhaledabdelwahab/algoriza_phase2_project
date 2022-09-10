import 'package:http/http.dart';

abstract class HttpService {
  void initHttpService();

  Future<Response> get({required Uri uri});
}
