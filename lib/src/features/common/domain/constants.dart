import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/domain/models/models.dart';

const String referral = '?utm_source=studeo&utm_medium=referral';

abstract class Constants {
  static const na = 'N/A';
  static const Duration kAnimationDuration = Duration(milliseconds: 200);

  /// Languages map
  static const languagesMap = {
    AppLanguageType.english: LanguageModel('en', 'US'),
  };

  static const String unsplashLink = 'https://unsplash.com/$referral';
}

abstract class RegExpConstants {
  static const String linkSuffix = r'(\)|]|,|\*)(.)*$';
  static const String number = '[0-9]+';
}
