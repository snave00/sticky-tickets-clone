import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router_const.dart';

class RouterFunc {
  RouterFunc._();

  static void goToInitialPage({required BuildContext context}) {
    context.goNamed(Pages.initial.routeName);
  }

  static void goToCurrentEventsPage({required BuildContext context}) {
    context.goNamed(Pages.currentEvents.routeName);
  }

  static void goToShellPage({
    required BuildContext context,
    required String shellOrigin,
  }) {
    // redirect to home branch.
    // we can't redirect to shell path bc there's no path for shell itself
    // bu default if you want to navigate to shell, use the branch path
    context.goNamed(
      Pages.home.routeName,
      queryParameters: <String, String>{
        RouterConst.shellOrigin: shellOrigin,
      },
    );
  }
}
