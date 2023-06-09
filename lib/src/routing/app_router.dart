import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/features/gallery/presentation/gallery_page.dart';
import 'package:studeo/src/features/item/domain/models/models.dart';
import 'package:studeo/src/features/item/presentation/item_page.dart';

enum AppRoute {
  onboarding('/onboarding'),
  gallery('/'),
  item('/item');

  const AppRoute(this.path);

  final String path;
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static const Duration duration = Duration(milliseconds: 700);

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const Placeholder(),
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

              return CustomTransitionPage(
                key: state.pageKey,
                child: ItemPage(
                  item: args.item,
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: duration,
                reverseTransitionDuration: duration,
                opaque: false,
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
