import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/gallery_grid_view.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

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
  }
}
