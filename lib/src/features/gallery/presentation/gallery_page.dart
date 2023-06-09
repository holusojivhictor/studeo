import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/features/gallery/application/gallery_bloc.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/gallery_grid_view.dart';
import 'package:studeo/src/features/item/domain/models/models.dart';
import 'package:studeo/src/routing/app_router.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _didChangeDependencies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeDependencies) return;
    _didChangeDependencies = true;
    context.read<GalleryBloc>().add(const GalleryEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GalleryGridView(
        onItemTapped: onItemTapped,
      ),
    );
  }

  void onItemTapped(Item item) {
    final args = ItemPageArgs(item: item);

    context.go(AppRoute.item.path, extra: args);
  }
}
