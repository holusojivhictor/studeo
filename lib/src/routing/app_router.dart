import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/features/gallery/presentation/gallery_page.dart';

enum AppRoute {
  onboarding,
  gallery,
  item,
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

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
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Placeholder(),
                transitionDuration: const Duration(milliseconds: 700),
                reverseTransitionDuration: const Duration(milliseconds: 700),
                opaque: false,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
