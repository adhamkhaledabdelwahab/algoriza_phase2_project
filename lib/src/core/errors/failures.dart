class Failure {
  final String errMessage;

  const Failure({
    required this.errMessage,
  });
}

class ServerFailure extends Failure {
  ServerFailure() : super(errMessage: 'Server Failure!');
}

class NetworkConnectionFailure extends Failure {
  NetworkConnectionFailure() : super(errMessage: 'Network Connection Failure!');
}

class LocationFailure extends Failure {
  LocationFailure() : super(errMessage: 'Location Connection Failure!');
}

class UnKnownFailure extends Failure {
  UnKnownFailure() : super(errMessage: 'UnExpected Failure!');
}
