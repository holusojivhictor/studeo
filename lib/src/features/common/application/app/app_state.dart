part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    required this.appTitle,
    required this.theme,
    required this.autoThemeMode,
    required this.initialized,
    required this.firstInstall,
    required this.versionChanged,
  });

  const AppState.init()
      : appTitle = '',
        theme = AppThemeType.dark,
        autoThemeMode = AutoThemeModeType.off,
        initialized = true,
        firstInstall = true,
        versionChanged = false;

  final String appTitle;
  final AppThemeType theme;
  final AutoThemeModeType autoThemeMode;
  final bool initialized;
  final bool firstInstall;
  final bool versionChanged;

  AppState copyWith({
    String? appTitle,
    AppThemeType? theme,
    AutoThemeModeType? autoThemeMode,
    bool? initialized,
    bool? firstInstall,
    bool? versionChanged,
  }) {
    return AppState(
      appTitle: appTitle ?? this.appTitle,
      theme: theme ?? this.theme,
      autoThemeMode: autoThemeMode ?? this.autoThemeMode,
      initialized: initialized ?? this.initialized,
      firstInstall: firstInstall ?? this.firstInstall,
      versionChanged: versionChanged ?? this.versionChanged,
    );
  }

  @override
  List<Object?> get props => [
    appTitle,
    theme,
    autoThemeMode,
    initialized,
    firstInstall,
    versionChanged,
  ];
}
