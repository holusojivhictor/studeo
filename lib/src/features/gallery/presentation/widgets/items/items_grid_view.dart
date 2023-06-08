import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/grid.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/photo_tile.dart';

class ItemsGridView<T extends Item> extends StatelessWidget {
  const ItemsGridView({
    required this.items,
    required this.refreshController,
    required this.onTap,
    super.key,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
  });

  final bool enablePullDown;
  final List<T> items;
  final RefreshController refreshController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final void Function(T) onTap;

  static List<String> test = images;

  @override
  Widget build(BuildContext context) {
    final child = GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 2,
      ),
      children: <Widget>[
        ...items.map((T e) {
          return GestureDetector(
            onTap: () => onTap(e),
            child: PhotoTile(
              heroTag: e.url,
              url: e.url,
            ),
          );
        }),
      ],
    );

    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: enablePullDown,
      header: const MaterialClassicHeader(),
      controller: refreshController,
      onLoading: onLoadMore,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
