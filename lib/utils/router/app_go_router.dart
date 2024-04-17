import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/presentation/pages/shell/shell_wrapper.dart';
import '../../features/account/presentation/pages/account_page_wrapper.dart';
import '../../features/activity/presentation/pages/activity_page_wrapper.dart';
import '../../features/cart/presentation/pages/cart_page_wrapper.dart';
import '../../features/current_events/presentation/pages/current_events_page_wrapper.dart';
import '../../features/home/presentation/pages/home_page_wrapper.dart';
import '../../features/initial/presentation/pages/initial_page_wrapper.dart';
import '../enums/enums.dart';
import 'router_const.dart';

class AppGoRouter {
  AppGoRouter._();

  // private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
    debugLabel: 'home_key',
  );
  static final _shellNavigatorActivityKey = GlobalKey<NavigatorState>(
    debugLabel: 'activity_key',
  );
  static final _shellNavigatorCartKey = GlobalKey<NavigatorState>(
    debugLabel: 'cart_key',
  );
  static final _shellNavigatorAccountKey = GlobalKey<NavigatorState>(
    debugLabel: 'account_key',
  );

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Pages.initial.routePath,
        name: Pages.initial.routeName,
        builder: (ctx, state) => const InitialPageWrapper(),
        routes: [
          GoRoute(
            path: Pages.currentEvents.routePath,
            name: Pages.currentEvents.routeName,
            builder: (ctx, state) => const CurrentEventsPageWrapper(),
          ),
        ],
      ),

      // * statefulshellroute for bottom nav bar
      _buildStatefulShellRoute(),
    ],
  );

  static RouteBase _buildStatefulShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final shellOrigin =
            state.uri.queryParameters[RouterConst.shellOrigin] ??
                ShellOrigin.manualSignIn.name;

        // the ui shell
        return ShellWrapper(
          navigationShell: navigationShell,
          shellOrigin: shellOrigin,
        );
      },
      branches: [
        _buildHomeBranch(),
        _buildActivityBranch(),
        _buildCartBranch(),
        _buildAccountBranch(),
      ],
    );
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeKey,
      routes: [
        // top route inside branch
        GoRoute(
          path: Pages.home.routePath,
          name: Pages.home.routeName,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePageWrapper(),
          ),
        ),
      ],
    );
  }

  static StatefulShellBranch _buildActivityBranch() {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorActivityKey,
      routes: [
        // top route inside branch
        GoRoute(
          path: Pages.activity.routePath,
          name: Pages.activity.routeName,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ActivityPageWrapper(),
          ),
        ),
      ],
    );
  }

  static StatefulShellBranch _buildCartBranch() {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorCartKey,
      routes: [
        // top route inside branch
        GoRoute(
          path: Pages.cart.routePath,
          name: Pages.cart.routeName,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CartPageWrapper(),
          ),
        ),
      ],
    );
  }

  static StatefulShellBranch _buildAccountBranch() {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorAccountKey,
      routes: [
        // top route inside branch
        GoRoute(
          path: Pages.account.routePath,
          name: Pages.account.routeName,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AccountPageWrapper(),
          ),
        ),
      ],
    );
  }
}
