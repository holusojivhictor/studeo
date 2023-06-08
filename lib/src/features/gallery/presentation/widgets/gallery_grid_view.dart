import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/items_grid_view.dart';

class GalleryGridView extends StatefulWidget {
  const GalleryGridView({
    required this.onItemTapped,
    super.key,
  });

  final ValueChanged<Item> onItemTapped;

  @override
  State<GalleryGridView> createState() => _GalleryGridViewState();
}

class _GalleryGridViewState extends State<GalleryGridView> {
  final RefreshController refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onItemTapped = widget.onItemTapped;

    return ItemsGridView<Item>(
      refreshController: refreshController,
      items: const [],
      onTap: onItemTapped,
      onRefresh: () {},
      onLoadMore: () {},
    );
  }
}
