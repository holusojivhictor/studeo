import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/features/common/application/bloc.dart';
import 'package:studeo/src/features/common/domain/assets.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/gallery/application/gallery_bloc.dart';
import 'package:studeo/src/routing/app_router.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({super.key});

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsBloc>();
    final first = settings.isFirstInstall;

    context.read<GalleryBloc>().add(const GalleryEvent.init());
    Future.delayed(Duration(milliseconds: first ? 4000 : 3000), () {
      context.go(AppRoute.gallery.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'ⓒ 2023 Morpheus',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Constants.splashLogoDimension,
                    height: Constants.splashLogoDimension,
                    child: Image.asset(Assets.loading),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Studeo',
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
