import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubit/user_cubit.dart';
import '../../../../modules/di/injection.dart';
import '../../../../utils/constants/string_const.dart';
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
              handleGuestsTotalState(
                context: context,
                theme: theme,
                state: eventState,
              );
              handleCheckedInGuestsTotalState(
                context: context,
                theme: theme,
                state: eventState,
              );
              handleCheckedInTicketState(
                context: context,
                theme: theme,
                state: eventState,
              );
              handleCheckedOutTicketState(
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

      case EventDetailStatus.loading:
        return;

      case EventDetailStatus.success:
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

  void handleTicketsState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.getTicketsStatus) {
      case GetTicketsStatus.initial:
        return;

      case GetTicketsStatus.loading:
        return;

      case GetTicketsStatus.success:
        return;

      case GetTicketsStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }

  void handleGuestsTotalState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.getGuestsTotalStatus) {
      case GetGuestsTotalStatus.initial:
        return;

      case GetGuestsTotalStatus.loading:
        return;

      case GetGuestsTotalStatus.success:
        return;

      case GetGuestsTotalStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }

  void handleCheckedInGuestsTotalState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.getCheckedInGuestsTotalStatus) {
      case GetCheckedInGuestsTotalStatus.initial:
        return;

      case GetCheckedInGuestsTotalStatus.loading:
        return;

      case GetCheckedInGuestsTotalStatus.success:
        return;

      case GetCheckedInGuestsTotalStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }

  void handleCheckedInTicketState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.checkedInTicketStatus) {
      case CheckedInTicketStatus.initial:
        return;

      case CheckedInTicketStatus.loading:
        return;

      case CheckedInTicketStatus.success:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: true,
          message: StringConst.guestCheckInSuccess,
        );
        return;

      case CheckedInTicketStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }

  void handleCheckedOutTicketState({
    required BuildContext context,
    required ThemeData theme,
    required EventDetailState state,
  }) async {
    switch (state.checkedOutTicketStatus) {
      case CheckedOutTicketStatus.initial:
        return;

      case CheckedOutTicketStatus.loading:
        return;

      case CheckedOutTicketStatus.success:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: true,
          message: StringConst.guestCheckOutSuccess,
        );
        return;

      case CheckedOutTicketStatus.failure:
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
