import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router_const.dart';

class RouterFunc {
  RouterFunc._();

  static void goToInitialPage({required BuildContext context}) {
    context.goNamed(Pages.initial.routeName);
  }

  static Future<void> goToEventsPage({required BuildContext context}) async {
    await context.pushNamed(Pages.events.routeName);
  }

  static Future<void> goToEventDetailPage({
    required BuildContext context,
    required String eventId,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      RouterConst.eventId: eventId,
    };

    await context.pushNamed(
      Pages.eventDetail.routeName,
      queryParameters: queryParameters,
    );
  }

  static Future<void> goToScanTicketPage({
    required BuildContext context,
    required String eventId,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      RouterConst.eventId: eventId,
    };

    await context.pushNamed(
      Pages.scanTicket.routeName,
      queryParameters: queryParameters,
    );
  }
}
