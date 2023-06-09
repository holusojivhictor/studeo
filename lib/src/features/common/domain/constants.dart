import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/domain/models/models.dart';

abstract class Constants {
  static const na = 'N/A';
  static const Duration kAnimationDuration = Duration(milliseconds: 200);

  /// Languages map
  static const languagesMap = {
    AppLanguageType.english: LanguageModel('en', 'US'),
  };
}
