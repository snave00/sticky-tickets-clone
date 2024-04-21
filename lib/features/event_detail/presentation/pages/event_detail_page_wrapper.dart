import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubit/user_cubit.dart';
import '../../../../modules/di/injection.dart';
import '../../../../utils/helpers/shared/helper_func.dart';
import '../../../../utils/helpers/shared/helper_state.func.dart';
import '../cubit/event_detail_cubit.dart';
import 'event_detail_page.dart';

class EventDetailPageWrapper extends StatelessWidget {
  final String eventId;

  const EventDetailPageWrapper({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (ctx) => sl<EventDetailCubit>()..init(eventId: eventId),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, UserState>(
            listener: (ctx, state) {
              handleUserState(context: context, theme: theme, state: state);
            },
          ),
          BlocListener<EventDetailCubit, EventDetailState>(
            listener: (ctx, eventState) {
              handleEventDetailState(
                context: context,
                theme: theme,
                state: eventState,
              );
            },
          ),
        ],
        child: const EventDetailPage(),
      ),
    );
  }

  void handleEventDetailState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.eventDetailStatus) {
      case EventDetailStatus.initial:
        return;

      case EventDetailStatus.getEventLoading:
        return;

      case EventDetailStatus.getEventSuccess:
        return;

      case EventDetailStatus.failure:
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
