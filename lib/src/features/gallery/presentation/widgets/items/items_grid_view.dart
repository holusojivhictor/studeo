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
  final void Function(T, int) onTap;
  final int crossAxisCount;
  final int maxItemsPerViewport;

  @override
  State<ItemsGridView<T>> createState() => _ItemsGridViewState<T>();
}

class _ItemsGridViewState<T extends Item> extends State<ItemsGridView<T>> {
  late List<Widget> viewports;
  int _upperOffset = 0;

  List<Widget> _generateViewports() {
    final items = widget.items;
    final slicedChildren = items.slices(widget.maxItemsPerViewport).toList();

    return List.generate(
      slicedChildren.length,
      (urlsSliceIndex) {
        final childrenSlice = slicedChildren[urlsSliceIndex];

        return MasonryGrid(
          children: <Widget>[
            ...childrenSlice.map((T e) {
              final index = items.indexOf(e);
              return GestureDetector(
                onTap: () => widget.onTap(e, index),
                child: PhotoTile(
                  heroTag: 'hero $index',
                  url: e.regular,
                ),
              );
            }),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    viewports = _generateViewports();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemsGridView<T> oldWidget) {
    if (oldWidget.crossAxisCount != widget.crossAxisCount ||
        oldWidget.maxItemsPerViewport != widget.maxItemsPerViewport ||
        oldWidget.items.length != widget.items.length) {
      viewports = _generateViewports();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return InteractiveGrid(
      viewportSize: screenSize,
      crossAxisCount: widget.crossAxisCount,
      snapDuration: const Duration(milliseconds: 700),
      onChanged: (int offset) {
        if (offset > _upperOffset) {
          _upperOffset = offset;
          widget.onLoadMore?.call();
        }
      },
      children: viewports,
    );
  }
}
