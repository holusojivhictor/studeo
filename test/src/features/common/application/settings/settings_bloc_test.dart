import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:studeo/src/features/common/application/bloc.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/domain/models/models.dart';

import '../../../../../mocks.dart';

class _FakeAppBloc extends Fake implements AppBloc {
  @override
  void add(AppEvent event) {}
}

void main() {
  const appVersion = '1.0.0';
  final defaultSettings = AppSettings(
    appTheme: AppThemeType.light,
    appLanguage: AppLanguageType.english,
    isFirstInstall: true,
    doubleBackToClose: true,
    complexGridTile: true,
    themeMode: AutoThemeModeType.off,
  );

  SettingsBloc getBloc({AppSettings? appSettings}) {
    final settings = appSettings ?? defaultSettings;
    final settingsService = MockSettingsService();
    when(() => settingsService.appSettings).thenReturn(settings);
    when(() => settingsService.autoThemeMode).thenReturn(settings.themeMode);
    when(() => settingsService.appTheme).thenReturn(settings.appTheme);
    when(() => settingsService.language).thenReturn(settings.appLanguage);
    when(
      () => settingsService.isFirstInstall,
    ).thenReturn(settings.isFirstInstall);
    when(
      () => settingsService.doubleBackToClose,
    ).thenReturn(settings.doubleBackToClose);
    when(
      () => settingsService.complexGridTile,
    ).thenReturn(settings.complexGridTile);

    final deviceInfoService = MockDeviceInfoService();
    when(() => deviceInfoService.versionWithBuildNumber).thenReturn(appVersion);
    when(() => deviceInfoService.appName).thenReturn('Studeo');

    final appBloc = _FakeAppBloc();

    return SettingsBloc(
      settingsService,
      deviceInfoService,
      appBloc,
    );
  }

  test('Initial state', () {
    expect(getBloc().state, const SettingsState.init());
  });

  group('Getter', () {
    test('doubleBackToClose returns valid value', () {
      expect(getBloc().doubleBackToClose, defaultSettings.doubleBackToClose);
    });

    test('isFirstInstall returns valid value', () {
      expect(getBloc().isFirstInstall, defaultSettings.isFirstInstall);
    });
  });

  blocTest<SettingsBloc, SettingsState>(
    'Init',
    build: getBloc,
    act: (bloc) => bloc.add(const SettingsEvent.init()),
    expect: () => <SettingsState>[
      const SettingsState.init().copyWith(
        currentTheme: defaultSettings.appTheme,
        currentLanguage: defaultSettings.appLanguage,
        appVersion: appVersion,
        doubleBackToClose: defaultSettings.doubleBackToClose,
        complexGridTile: defaultSettings.complexGridTile,
        themeMode: defaultSettings.themeMode,
      ),
    ],
  );

  blocTest<SettingsBloc, SettingsState>(
    'Settings changed',
    build: getBloc,
    act: (bloc) => bloc
      ..add(const SettingsEvent.init())
      ..add(const SettingsEvent.themeChanged(newValue: AppThemeType.dark))
      ..add(
        const SettingsEvent.autoThemeModeTypeChanged(
          newValue: AutoThemeModeType.on,
        ),
      )
      ..add(
        SettingsEvent.doubleBackToCloseChanged(
          newValue: !defaultSettings.doubleBackToClose,
        ),
      )
      ..add(
        SettingsEvent.complexGridTileChanged(
          newValue: !defaultSettings.complexGridTile,
        ),
      ),
    skip: 4,
    expect: () => <SettingsState>[
      const SettingsState.init().copyWith(
        currentTheme: AppThemeType.dark,
        currentLanguage: AppLanguageType.english,
        themeMode: AutoThemeModeType.on,
        appVersion: appVersion,
        doubleBackToClose: !defaultSettings.doubleBackToClose,
        complexGridTile: !defaultSettings.complexGridTile,
      ),
    ],
  );
}
