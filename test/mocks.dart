import 'package:mocktail/mocktail.dart';
import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';

class MockLoggingService extends Mock implements LoggingService {}

class MockDeviceInfoService extends Mock implements DeviceInfoService {}

class MockSettingsService extends Mock implements SettingsService {}

class MockUnsplashService extends Mock implements UnsplashService {}
