import 'package:get_it/get_it.dart';
import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';
import 'package:studeo/src/features/gallery/infrastructure/gallery_service.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final deviceInfoService = DeviceInfoService();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingService();
    getIt.registerSingleton<LoggingService>(loggingService);

    final settingsService = SettingsService(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);

    final unsplashService = UnsplashService();
    await unsplashService.init();
    getIt.registerSingleton<UnsplashService>(unsplashService);

    final galleryService = GalleryService(unsplashService);
    getIt.registerSingleton<GalleryService>(galleryService);
  }
}
