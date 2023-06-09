import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({
    required this.item,
    super.key,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO(morpheus): Set url to full and add placeholder

    return Scaffold(
      body: Hero(
        tag: 'hero ${item.id}',
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: CachedNetworkImage(
            imageUrl: item.regular,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
