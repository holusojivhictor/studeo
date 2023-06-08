import 'package:studeo/src/config/config.dart';
import 'package:unsplash_client/unsplash_client.dart';

class UnsplashService {
  UnsplashClient get client => _client;

  late final UnsplashClient _client;

  Future<void> init() async {
    _client = UnsplashClient(
      settings: const ClientSettings(
        credentials: AppCredentials(
          accessKey: Config.accessKey,
          secretKey: Config.secretKey,
        ),
      ),
    );
  }

  void close() => _client.close();
}
