import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:studeo/src/features/common/presentation/preview.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({
    required this.url,
    required this.hash,
    required this.heroTag,
    super.key,
    this.heroEnabled = true,
  });

  final String url;
  final String? hash;
  final String heroTag;
  final bool heroEnabled;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return HeroMode(
      enabled: heroEnabled,
      child: Hero(
        tag: heroTag,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, __) => FadeIn(
                child: PreviewPlaceHolder(
                  hash: hash,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
