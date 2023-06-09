import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/grid.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/photo_tile.dart';

class ItemsGridView<T extends Item> extends StatefulWidget {
  const ItemsGridView({
    required this.items,
    required this.onTap,
    super.key,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
    this.crossAxisCount = 2,
    this.maxItemsPerViewport = 10,
  });

  final bool enablePullDown;
  final List<T> items;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final void Function(T) onTap;
  final int crossAxisCount;
  final int maxItemsPerViewport;

  @override
  State<ItemsGridView<T>> createState() => _ItemsGridViewState<T>();
}

class _ItemsGridViewState<T extends Item> extends State<ItemsGridView<T>> {
  int _upperOffset = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final slicedChildren = widget.items.slices(widget.maxItemsPerViewport).toList();

    return InteractiveGrid(
      viewportSize: screenSize,
      crossAxisCount: widget.crossAxisCount,
      snapDuration: const Duration(milliseconds: 700),
      onChanged: (int offset) {
        if (offset > _upperOffset) {
          setState(() => _upperOffset = offset);
          widget.onLoadMore?.call();
        }
      },
      children: List.generate(
        slicedChildren.length,
        (urlsSliceIndex) {
          final childrenSlice = slicedChildren[urlsSliceIndex];

          return MasonryGrid(
            children: <Widget>[
              ...childrenSlice.map((T e) {
                return GestureDetector(
                  onTap: () => widget.onTap(e),
                  child: PhotoTile(
                    heroTag: 'hero ${e.id}',
                    url: e.regular,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
