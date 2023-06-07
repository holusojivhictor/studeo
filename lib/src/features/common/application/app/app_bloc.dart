import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    this._logger,
    this._settingsService,
    this._deviceInfoService,
  ) : super(const AppState.init()) {
    on<_Init>(_onInit);
    on<_ThemeChanged>(_onThemeChanged);
    on<_ThemeModeChanged>(_onThemeModeChanged);
  }

  final LoggingService _logger;
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;

  AppState loadedState(
    AppThemeType theme,
    AutoThemeModeType autoThemeMode, {
    bool isInitialized = true,
  }) {
    return const AppState.init().copyWith(
      appTitle: _deviceInfoService.appName,
      initialized: isInitialized,
      theme: theme,
      autoThemeMode: autoThemeMode,
      firstInstall: _settingsService.isFirstInstall,
      versionChanged: _deviceInfoService.versionChanged,
    );
  }

  void _logInfo() {
    _logger.info(
        runtimeType,
        '_init: Is first install = ${_settingsService.isFirstInstall}. '
            'Refreshing settings');
  }

  void _onInit(_Init event, Emitter<AppState> emit) {
    _logger.info(runtimeType, '_init: Initializing all...');

    final settings = _settingsService.appSettings;
    _logInfo();

    emit(loadedState(settings.appTheme, settings.themeMode));
  }

  void _onThemeChanged(_ThemeChanged event, Emitter<AppState> emit) {
    _logInfo();

    emit(loadedState(event.newValue, _settingsService.autoThemeMode));
  }

  void _onThemeModeChanged(_ThemeModeChanged event, Emitter<AppState> emit) {
    _logInfo();

    emit(loadedState(_settingsService.appTheme, event.newValue));
  }
}
