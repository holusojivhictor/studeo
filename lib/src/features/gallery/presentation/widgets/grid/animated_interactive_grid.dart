import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/interactive_grid.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/grid/masonry_grid.dart';

class AnimatedInteractiveGrid extends StatefulWidget {
  const AnimatedInteractiveGrid({
    super.key,
    this.children = const [],
    this.enableSnapping = true,
    this.crossAxisCount = 2,
    this.initialIndex = 0,
    this.maxItemsPerViewport = 1,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final bool enableSnapping;
  final int initialIndex;
  final int maxItemsPerViewport;

  @override
  State<AnimatedInteractiveGrid> createState() =>
      _AnimatedInteractiveGridState();
}

class _AnimatedInteractiveGridState extends State<AnimatedInteractiveGrid>
    with SingleTickerProviderStateMixin {
  late List<Widget> viewports;
  static Duration snapDuration = const Duration(milliseconds: 700);


  List<Widget> _generateViewports() {
    final slicedChildren =
        widget.children.slices(widget.maxItemsPerViewport).toList();

    return List.generate(
      slicedChildren.length,
      (urlsSliceIndex) {
        final childrenSlice = slicedChildren[urlsSliceIndex];

        return MasonryGrid(
          index: urlsSliceIndex,
          children: childrenSlice.toList(),
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
  void didUpdateWidget(covariant AnimatedInteractiveGrid oldWidget) {
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
      enableSnapping: widget.enableSnapping,
      snapDuration: snapDuration,
      initialIndex: widget.initialIndex,
      children: viewports,
    );
  }
}
