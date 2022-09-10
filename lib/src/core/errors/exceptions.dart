class WeatherAppException implements Exception {
  final String errMsg;

  WeatherAppException({
    required this.errMsg,
  });

  @override
  String toString() {
    return errMsg;
  }
}

class ServerException extends WeatherAppException {
  ServerException({required super.errMsg});

  @override
  String toString() {
    return super.errMsg;
  }
}

class NetworkException extends WeatherAppException {
  NetworkException({required super.errMsg});

  @override
  String toString() {
    return super.errMsg;
  }
}

class LocationException extends WeatherAppException {
  LocationException({required super.errMsg});

  @override
  String toString() {
    return super.errMsg;
  }
}

class UnKnownException extends WeatherAppException {
  UnKnownException({required super.errMsg});

  @override
  String toString() {
    return super.errMsg;
  }
}
