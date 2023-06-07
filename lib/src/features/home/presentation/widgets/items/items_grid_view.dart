import 'package:flutter/material.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/home/presentation/widgets/grid/animated_interactive_grid.dart';
import 'package:studeo/src/features/home/presentation/widgets/items/photo_tile.dart';

class ItemsGridView extends StatelessWidget {
  const ItemsGridView({super.key});

  static List<String> items = images;

  @override
  Widget build(BuildContext context) {
    return AnimatedInteractiveGrid(
      maxItemsPerViewport: 10,
      children: List.generate(
        items.length,
        (index) => GestureDetector(
          onTap: () {},
          child: PhotoTile(
            heroTag: '__hero_${index}__',
            imagePath: items[index],
          ),
        ),
      ),
    );
  }
}
