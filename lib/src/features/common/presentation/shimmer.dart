import 'package:flutter/material.dart';
import 'package:studeo/src/features/common/presentation/theme.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.placeHolderBase!,
            theme.placeHolderBase!,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
