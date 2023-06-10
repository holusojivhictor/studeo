import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/features/common/presentation/splash/animated_splash.dart';
import 'package:studeo/src/features/gallery/presentation/gallery_page.dart';
import 'package:studeo/src/features/item/domain/models/models.dart';
import 'package:studeo/src/features/item/presentation/item_page.dart';
import 'package:studeo/src/features/settings/presentation/settings_page.dart';
import 'package:studeo/src/utils/page_utils.dart';

enum AppRoute {
  splash('/splash'),
  gallery('/'),
  item('/item'),
  settings('/settings');

  const AppRoute(this.path);

  final String path;
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static const Duration duration = Duration(milliseconds: 700);

  static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/splash',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoute.splash.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AnimatedSplash(),
        ),
      ),
      GoRoute(
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoute.gallery.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const GalleryPage(),
        ),
        routes: [
          GoRoute(
            path: 'item',
            name: AppRoute.item.name,
            pageBuilder: (context, state) {
              final args = state.extra! as ItemPageArgs;

              return buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: ItemPage(
                  item: args.item,
                  index: args.index,
                ),
                transitionDuration: duration,
                reverseTransitionDuration: duration,
                opaque: false,
              );
            },
          ),
          GoRoute(
            path: 'settings',
            name: AppRoute.settings.name,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const SettingsPage(),
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
