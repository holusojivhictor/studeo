import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/buttons/settings_icon_button.dart';

class GalleryAppBar extends AppBar {
  GalleryAppBar({
    required Color super.backgroundColor,
    super.key,
  }) : super(
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            const SettingsIconButton(),
          ],
        );
}
