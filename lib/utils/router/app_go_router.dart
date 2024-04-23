import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/event_detail/presentation/pages/event_detail_page_wrapper.dart';
import '../../features/events/presentation/pages/events_page_wrapper.dart';
import '../../features/initial/presentation/pages/initial_page_wrapper.dart';
import '../../features/ticket/presentation/pages/scan_ticket_page_wrapper.dart';
import 'router_const.dart';

class AppGoRouter {
  AppGoRouter._();

  // private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

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
            path: Pages.events.routePath,
            name: Pages.events.routeName,
            builder: (ctx, state) => const EventsPageWrapper(),
          ),
          GoRoute(
            path: Pages.eventDetail.routePath,
            name: Pages.eventDetail.routeName,
            builder: (ctx, state) {
              final eventId =
                  state.uri.queryParameters[RouterConst.eventId] ?? '';

              return EventDetailPageWrapper(eventId: eventId);
            },
          ),
          GoRoute(
            path: Pages.scanTicket.routePath,
            name: Pages.scanTicket.routeName,
            builder: (ctx, state) {
              final eventId =
                  state.uri.queryParameters[RouterConst.eventId] ?? '';

              return ScanTicketPageWrapper(eventId: eventId);
            },
          ),
        ],
      ),
    ],
  );
}
