import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:studeo/src/features/common/application/bloc.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._settingsService,
    this._deviceInfoService,
    this._appBloc,
  ) : super(const SettingsState.init()) {
    on<_Init>(_onInit);
    on<_ThemeChanged>(_onThemeChanged);
    on<_LanguageChanged>(_onLanguageChanged);
    on<_DoubleBackToCloseChanged>(_onDoubleBackToCloseChanged);
    on<_ComplexGridTileChanged>(_onComplexGridTileChanged);
    on<_AutoThemeModeTypeChanged>(_onAutoThemeModeTypeChanged);
  }

  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;
  final AppBloc _appBloc;

  void _onInit(_Init event, Emitter<SettingsState> emit) {
    final settings = _settingsService.appSettings;

    emit(
      const SettingsState.init().copyWith(
        currentTheme: settings.appTheme,
        currentLanguage: settings.appLanguage,
        appVersion: _deviceInfoService.version,
        doubleBackToClose: settings.doubleBackToClose,
        complexGridTile: settings.complexGridTile,
        themeMode: settings.themeMode,
      ),
    );
  }

  void _onThemeChanged(_ThemeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.appTheme) {
      return emit(state);
    }
    _settingsService.appTheme = event.newValue;
    _appBloc.add(AppEvent.themeChanged(newValue: event.newValue));
    emit(state.copyWith(currentTheme: event.newValue));
  }

  void _onLanguageChanged(_LanguageChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.language) {
      return emit(state);
    }
    _settingsService.language = event.newValue;
    emit(state.copyWith(currentLanguage: event.newValue));
  }

  void _onDoubleBackToCloseChanged(
    _DoubleBackToCloseChanged event,
    Emitter<SettingsState> emit,
  ) {
    _settingsService.doubleBackToClose = event.newValue;
    emit(state.copyWith(doubleBackToClose: event.newValue));
  }

  void _onComplexGridTileChanged(
    _ComplexGridTileChanged event,
    Emitter<SettingsState> emit,
  ) {
    _settingsService.complexGridTile = event.newValue;
    emit(state.copyWith(complexGridTile: event.newValue));
  }

  void _onAutoThemeModeTypeChanged(_AutoThemeModeTypeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.autoThemeMode) {
      return emit(state);
    }
    _settingsService.autoThemeMode = event.newValue;
    _appBloc.add(AppEvent.themeModeChanged(newValue: event.newValue));
    emit(state.copyWith(themeMode: event.newValue));
  }

  bool get doubleBackToClose => _settingsService.doubleBackToClose;
}
