import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MasonryGrid extends StatefulWidget {
  const MasonryGrid({
    required this.index,
    super.key,
    this.children = const [],
  });

  final List<Widget> children;
  final int index;

  @override
  State<MasonryGrid> createState() => _MasonryGridState();
}

class _MasonryGridState extends State<MasonryGrid> {
  late List<Widget> rows;

  static const int maxItemsPerRow = 4;
  static Random random = Random(3);

  List<Widget> _generateRows() {
    final slicedChildren = widget.children.slices(maxItemsPerRow).toList();

    return List.generate(
      slicedChildren.length,
      (childrenSliceIndex) {
        final childrenSlice = slicedChildren[childrenSliceIndex];

        var mainRowChildren = <Widget>[];

        if (childrenSliceIndex.isEven && childrenSlice.length >= 3) {
          mainRowChildren = [
            Expanded(
              child: childrenSlice[0],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: random.nextInt(2) + 1,
                    child: childrenSlice[1],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: childrenSlice[2],
                        ),
                        if (childrenSlice.length == 4)
                          Expanded(
                            child: childrenSlice[3],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        } else {
          mainRowChildren = List.generate(
            childrenSlice.length,
            (imageIndex) {
              return Expanded(
                flex: random.nextInt(2) + 1,
                child: childrenSlice[imageIndex],
              );
            },
          );
        }

        return Expanded(
          flex: childrenSliceIndex.isOdd ? 1 : random.nextInt(3) + 1,
          child: Row(
            children: mainRowChildren,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    rows = _generateRows();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MasonryGrid oldWidget) {
    if (oldWidget.children != widget.children) {
      rows = _generateRows();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows.length, (i) => rows[i]),
    );
  }
}
