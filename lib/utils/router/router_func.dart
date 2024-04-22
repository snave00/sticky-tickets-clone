import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router_const.dart';

class RouterFunc {
  RouterFunc._();

  static void goToInitialPage({required BuildContext context}) {
    context.goNamed(Pages.initial.routeName);
  }

  static void goToEventsPage({required BuildContext context}) {
    context.pushNamed(Pages.events.routeName);
  }

  static void goToEventDetail({
    required BuildContext context,
    required String eventId,
  }) {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      RouterConst.eventId: eventId,
    };

    context.pushNamed(
      Pages.eventDetail.routeName,
      queryParameters: queryParameters,
    );
  }
}
