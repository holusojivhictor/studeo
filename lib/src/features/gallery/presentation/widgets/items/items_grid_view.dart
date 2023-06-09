import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/grid.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/photo_tile.dart';

class ItemsGridView<T extends Item> extends StatefulWidget {
  const ItemsGridView({
    required this.enableMasonGrid,
    required this.items,
    required this.onTap,
    required this.refreshController,
    super.key,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
    this.crossAxisCount = 2,
    this.maxItemsPerViewport = 10,
  });

  final bool enableMasonGrid;
  final bool enablePullDown;
  final List<T> items;
  final RefreshController refreshController;
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
    if (widget.enableMasonGrid) viewports = _generateViewports();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemsGridView<T> oldWidget) {
    if (widget.enableMasonGrid) {
      if (oldWidget.crossAxisCount != widget.crossAxisCount ||
          oldWidget.maxItemsPerViewport != widget.maxItemsPerViewport ||
          oldWidget.items.length != widget.items.length) {
        viewports = _generateViewports();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final grid = SmartRefresher(
      enablePullUp: true,
      enablePullDown: widget.enablePullDown,
      header: const MaterialClassicHeader(),
      controller: widget.refreshController,
      onLoading: widget.onLoadMore,
      onRefresh: widget.onRefresh,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: 1 / 2,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => widget.onTap(widget.items[index], index),
            child: PhotoTile(
              heroTag: 'hero $index',
              url: widget.items[index].regular,
            ),
          );
        },
      ),
    );

    if (!widget.enableMasonGrid) {
      return grid;
    }

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
