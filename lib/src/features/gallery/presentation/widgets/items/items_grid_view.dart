import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/grid.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/photo_tile.dart';

class ItemsGridView<T extends Item> extends StatefulWidget {
  const ItemsGridView({
    required this.items,
    required this.refreshController,
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
  final RefreshController refreshController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final void Function(T) onTap;
  final int crossAxisCount;
  final int maxItemsPerViewport;

  static List<String> test = images;

  @override
  State<ItemsGridView<T>> createState() => _ItemsGridViewState<T>();
}

class _ItemsGridViewState<T extends Item> extends State<ItemsGridView<T>> {
  late List<Widget> viewports;
  static Duration snapDuration = const Duration(milliseconds: 700);

  List<Widget> _generateViewports() {
    final slicedChildren = widget.items.slices(widget.maxItemsPerViewport).toList();

    return List.generate(
      slicedChildren.length, (urlsSliceIndex) {
        final childrenSlice = slicedChildren[urlsSliceIndex];

        return MasonryGrid(
          children: <Widget>[
            ...childrenSlice.map((T e) {
              return GestureDetector(
                onTap: () => widget.onTap(e),
                child: PhotoTile(
                  heroTag: e.id,
                  url: e.url,
                ),
              );
            })
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    viewports = _generateViewports();
  }

  @override
  void didUpdateWidget(covariant ItemsGridView<T> oldWidget) {
      if (oldWidget.crossAxisCount != widget.crossAxisCount ||
          oldWidget.maxItemsPerViewport != widget.maxItemsPerViewport) {
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
      onChanged: (int offset) {
        if (offset > 0) {
          widget.onLoadMore?.call();
        }
      },
      snapDuration: snapDuration,
      children: viewports,
    );
  }
}
