// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/services.dart';

enum AppThemeType {
  light(false),
  dark(true);

  const AppThemeType(this.darkMode);

  final bool darkMode;

  static AppThemeType translate(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
    }
  }

  SystemUiOverlayStyle get overlayStyle {
    switch (this) {
      case AppThemeType.light:
        return SystemUiOverlayStyle.light;
      case AppThemeType.dark:
        return SystemUiOverlayStyle.dark;
    }
  }
}
