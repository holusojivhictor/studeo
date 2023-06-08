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

const root = 'https://roaakdm.com';
const imagesDirectory = 'flutter-gallery-example/hd';

const List<String> images = [
  'https://images.unsplash.com/photo-1682685794690-dea7c8847a50?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686079746732-ab2a86a36b82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHwyfHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686007624910-21930ff29565?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHwzfHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686148016905-b08dafa868af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686174484623-9402d1d36ba5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHw1fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1674574124473-e91fdcabaefc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MXwxfGFsbHw2fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686174212933-d41cd617ebe6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHw3fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1686174779175-f5d9dabb3eb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHw4fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1684020273098-95959b732b42?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHw5fHx8fHx8Mnx8MTY4NjIyOTMxOHw&ixlib=rb-4.0.3&q=80&w=1080',
  'https://images.unsplash.com/photo-1685743794067-ae990252216d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTg5MTJ8MHwxfGFsbHwxMHx8fHx8fDJ8fDE2ODYyMjkzMTh8&ixlib=rb-4.0.3&q=80&w=1080',
];
