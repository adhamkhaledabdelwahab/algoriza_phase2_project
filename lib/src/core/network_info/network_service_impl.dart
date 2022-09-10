import 'package:weather_app/src/core/network_info/network_info.dart';

class NetworkServiceImpl implements NetworkService {
  final NetworkProvider networkProvider;

  const NetworkServiceImpl({
    required this.networkProvider,
  });

  @override
  Future<bool> get isConnected async =>
      await networkProvider.get().hasConnection;
}
