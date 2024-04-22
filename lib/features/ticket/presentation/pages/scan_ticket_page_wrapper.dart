import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/di/injection.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/helpers/shared/helper_func.dart';
import '../../domain/entities/ticket_entity.dart';
import '../cubit/ticket_cubit.dart';
import 'scan_ticket_page.dart';

class ScanTicketPageWrapper extends StatelessWidget {
  final String eventId;

  const ScanTicketPageWrapper({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (ctx) => sl<TicketCubit>()..init(eventId: eventId),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TicketCubit, TicketState>(
            listener: (ctx, state) {
              handleScanTicketState(
                context: context,
                theme: theme,
                state: state,
              );
            },
          ),
        ],
        child: const ScanTicketPage(),
      ),
    );
  }

  void handleScanTicketState({
    required BuildContext context,
    required ThemeData theme,
    required TicketState state,
  }) async {
    switch (state.scanTicketStatus) {
      case ScanTicketStatus.initial:
        return;

      case ScanTicketStatus.loading:
        await showProgressDialog(context: context);
        return;

      case ScanTicketStatus.success:
        // close progress dialog
        Navigator.pop(context);

        await showScanTicketResultBottomSheet(
          context: context,
          isSuccess: true,
          resultMessage: StringConst.scanTicketSuccess,
          ticketEntity: state.ticketEntity,
        );

        // close current page
        if (context.mounted) {
          context.pop(context);
        }

        return;

      case ScanTicketStatus.failure:
        // close progress dialog
        Navigator.pop(context);

        await showScanTicketResultBottomSheet(
          context: context,
          isSuccess: false,
          resultMessage: state.errorMessage ?? '',
          ticketEntity: TicketEntity.empty(),
        );

        // close current page
        if (context.mounted) {
          context.pop(context);
        }

        return;
    }
  }
}
