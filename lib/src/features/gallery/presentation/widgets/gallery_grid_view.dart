import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:studeo/src/features/gallery/application/gallery_bloc.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/items/items_grid_view.dart';

typedef ValueChangedCallback<T, int> = void Function(T value, int index);

class GalleryGridView extends StatefulWidget {
  const GalleryGridView({
    required this.onItemTapped,
    super.key,
  });

  final ValueChangedCallback<Item, int> onItemTapped;

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

    return BlocConsumer<GalleryBloc, GalleryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (ctx, state) {
        if (state.status == ImagesStatus.loaded) {
          refreshController..refreshCompleted()..loadComplete();
        }
      },
      buildWhen: buildWhen,
      builder: (ctx, state) {
        return ItemsGridView<Item>(
          items: state.items,
          onTap: onItemTapped,
          onRefresh: () {
            HapticFeedback.lightImpact();
            context.read<GalleryBloc>().add(const GalleryEvent.refresh());
          },
          onLoadMore: () {
            context.read<GalleryBloc>().add(const GalleryEvent.loadMore());
          },
        );
      },
    );
  }

  bool buildWhen(GalleryState previous, GalleryState current) {
    return (current.currentPage == 1 && previous.currentPage == 1) ||
        (previous.items.length != current.items.length);
  }
}
