import 'package:flutter/material.dart';

import '../../../core/presentation/cubit/user_cubit.dart';
import '../../logs/custom_log.dart';
import 'helper_func.dart';

// * The global listener for user cubit and user state
// * It will listen to all child widgets because user cubit was set to [main.dart]
// * This is a reusable function. Can be used in:
// * Parent of AuthPages (SignInProviderPage, SignUpPage, SignInPage, EmailVerifiaction Page)
// * Parent of RootPages (HomePage, StatisticsPage...)
// - Needs to handle both AuthPages and RootPages bc it's both Top level route
// - Needs a new BlocListener for both AuthPages and RootPages so it can be listened
void handleUserState({
  required BuildContext context,
  required ThemeData theme,
  required UserState state,
}) async {
  switch (state.userStatus) {
    case UserStatus.initial:
      Log.logUserStatus(userStatus: UserStatus.initial.name);
      return;

    case UserStatus.loading:
      Log.logUserStatus(userStatus: UserStatus.loading.name);
      await showProgressDialog(context: context);
      return;

    case UserStatus.success:
      Log.logUserStatus(userStatus: UserStatus.success.name);
      // close progress dialog
      Navigator.pop(context);
      return;

    case UserStatus.getUserSuccess:
      Log.logUserStatus(userStatus: UserStatus.getUserSuccess.name);
      // close progress dialog
      Navigator.pop(context);
      return;

    case UserStatus.failure:
      Log.logUserStatus(userStatus: UserStatus.failure.name);
      // close progress dialog
      Navigator.pop(context);
      showSnackBar(
        context: context,
        theme: theme,
        isSuccess: false,
        message: state.errorMessage ?? '',
      );
      return;
  }
}
