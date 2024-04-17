import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubit/user_cubit.dart';
import '../../../../modules/di/injection.dart';
import '../../../../utils/helpers/shared/helper_func.dart';
import '../../../../utils/helpers/shared/helper_state.func.dart';
import '../cubit/cubit/current_events_cubit.dart';
import 'current_events_page.dart';

class CurrentEventsPageWrapper extends StatelessWidget {
  const CurrentEventsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (ctx) => sl<CurrentEventsCubit>()..init(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, UserState>(
            listener: (ctx, state) {
              handleUserState(context: context, theme: theme, state: state);
            },
          ),
          BlocListener<CurrentEventsCubit, CurrentEventsState>(
            listener: (ctx, eventState) {
              handleEventState(
                context: context,
                theme: theme,
                state: eventState,
              );
            },
          ),
        ],
        child: const CurrentEventsPage(),
      ),
    );
  }

  void handleEventState({
    required BuildContext context,
    required ThemeData theme,
    required CurrentEventsState state,
  }) async {
    switch (state.currentEventsStatus) {
      case CurrentEventsStatus.initial:
        return;

      case CurrentEventsStatus.getEventsLoading:
        return;

      case CurrentEventsStatus.getEventsSuccess:
        return;

      case CurrentEventsStatus.getEventLoading:
        return;

      case CurrentEventsStatus.getEventSuccess:
        return;

      case CurrentEventsStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }
}
