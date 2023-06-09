import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/item/presentation/widgets/buttons/link_icon_button.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required Item item,
    required Widget super.leading,
    required Color super.backgroundColor,
    super.key,
  }) : super(
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            LinkIconButton(id: item.id),
          ],
        );
}
