import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/routing/app_router.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Open settings screen',
      icon: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.5),
        child: const Icon(Icons.settings, color: Colors.white),
      ),
      onPressed: () => context.go(AppRoute.settings.path),
    );
  }
}
