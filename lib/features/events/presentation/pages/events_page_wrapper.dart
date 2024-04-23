import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubit/user_cubit.dart';
import '../../../../modules/di/injection.dart';
import '../../../../utils/helpers/shared/helper_func.dart';
import '../../../../utils/helpers/shared/helper_state.func.dart';
import '../cubit/cubit/events_cubit.dart';
import 'events_page.dart';

class EventsPageWrapper extends StatelessWidget {
  const EventsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (ctx) => sl<EventsCubit>()..init(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, UserState>(
            listener: (ctx, state) {
              handleUserState(context: context, theme: theme, state: state);
            },
          ),
          BlocListener<EventsCubit, EventsState>(
            listener: (ctx, eventState) {
              handleEventState(
                context: context,
                theme: theme,
                state: eventState,
              );
            },
          ),
        ],
        child: const EventsPage(),
      ),
    );
  }

  void handleEventState({
    required BuildContext context,
    required ThemeData theme,
    required EventsState state,
  }) async {
    switch (state.eventsStatus) {
      case EventsStatus.initial:
        return;

      case EventsStatus.getEventsLoading:
        return;

      case EventsStatus.getEventsSuccess:
        return;

      case EventsStatus.failure:
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
