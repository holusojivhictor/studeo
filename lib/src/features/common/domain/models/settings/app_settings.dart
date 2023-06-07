import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  factory AppSettings({
    required AppThemeType appTheme,
    required AppLanguageType appLanguage,
    required bool isFirstInstall,
    required bool doubleBackToClose,
    required AutoThemeModeType themeMode,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
