import 'package:flutter/material.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/presentation/colors.dart';
import 'package:studeo/src/features/common/presentation/theme.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF1F1F1),
      typography: AppTheme.appMaterialTypography,
      primaryTextTheme: AppTheme.appMaterialLightPrimaryTextTheme,
      textTheme: AppTheme.appMaterialLightTextTheme,
      colorScheme: AppTheme.appMaterialLightColorScheme,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension(
          baseTextColor: Colors.black,
          placeHolderBase: AppColors.grey3,
          placeHolderHighlight: AppColors.grey1,
        ),
      ],
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      typography: AppTheme.appMaterialTypography,
      primaryTextTheme: AppTheme.appMaterialDarkPrimaryTextTheme,
      textTheme: AppTheme.appMaterialDarkTextTheme,
      colorScheme: AppTheme.appMaterialDarkColorScheme,
      extensions: <ThemeExtension<dynamic>>[
        AppThemeExtension(
          baseTextColor: Colors.white,
          placeHolderBase: AppColors.variantGrey3,
          placeHolderHighlight: AppColors.variantGrey1,
        ),
      ],
    );
  }

  ThemeData getThemeData() {
    switch (this) {
      case AppThemeType.light:
        return lightTheme();
      case AppThemeType.dark:
        return darkTheme();
    }
  }
}
