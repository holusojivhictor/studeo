import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    required this.label,
    super.key,
    this.color,
    this.textColor,
  });

  final String label;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: textTheme.bodySmall!.copyWith(color: textColor),
      ),
    );
  }
}
