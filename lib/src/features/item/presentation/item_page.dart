import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({
    required this.item,
    required this.index,
    super.key,
  });

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Hero(
      tag: 'hero $index',
      child: Scaffold(
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: item.full,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _PreviewPlaceHolder(url: item.regular),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      item.description?.toUpperCase() ?? '',
                      style: textTheme.titleLarge!.copyWith(
                        fontSize: 24,
                        letterSpacing: 1,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewPlaceHolder extends StatelessWidget {
  const _PreviewPlaceHolder({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
    );
  }
}
