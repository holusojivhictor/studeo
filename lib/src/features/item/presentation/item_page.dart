import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studeo/src/extensions/extensions.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/item/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:studeo/src/utils/utils.dart';

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

    final descStyle = textTheme.titleLarge!.copyWith(
      fontSize: 24,
      letterSpacing: 1,
      height: 1.4,
    );

    return Hero(
      tag: 'hero $index',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
            ),
          ),
          item: item,
        ),
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: item.full,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      _PreviewPlaceHolder(url: item.regular),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: screenSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Wrap(
                          children: [
                            if (item.tags.isNotNull)
                              ...item.tags!.map((e) {
                                return Chip(label: Text(e.title));
                              }),
                          ],
                        ),
                      ),
                      if (item.desc.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            item.desc,
                            style: descStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: LinkableSpan(
                          author: item.author,
                          page: item.creatorPage,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
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

class LinkableSpan extends StatelessWidget {
  const LinkableSpan({
    required this.author,
    required this.page,
    super.key,
  });

  final String author;
  final String page;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final style = textTheme.bodySmall!.copyWith(
      fontSize: 14,
    );
    final linkStyle = style.copyWith(
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Photo by ',
            style: style,
          ),
          TextSpan(
            text: author,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => LinkUtils.launch(page),
          ),
          TextSpan(
            text: ' on ',
            style: style,
          ),
          TextSpan(
            text: 'Unsplash',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => LinkUtils.launch(Constants.unsplashLink),
          ),
        ],
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
