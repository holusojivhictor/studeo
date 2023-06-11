import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:studeo/src/extensions/extensions.dart';
import 'package:studeo/src/features/common/presentation/theme.dart';

class PreviewPlaceHolder extends StatelessWidget {
  const PreviewPlaceHolder({required this.hash, super.key});

  final String? hash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.placeHolderBase,
      ),
      child: hash.isNotNullNorEmpty
          ? BlurHash(
              hash: hash!,
              imageFit: BoxFit.cover,
            )
          : null,
    );
  }
}
