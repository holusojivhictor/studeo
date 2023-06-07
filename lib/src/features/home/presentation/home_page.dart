import 'package:flutter/material.dart';
import 'package:studeo/src/features/home/presentation/widgets/home_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: HomeGridView(),
    );
  }
}
