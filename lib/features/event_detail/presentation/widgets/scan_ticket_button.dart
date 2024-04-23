import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/button/custom_filled_button.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/router/router_func.dart';
import '../cubit/event_detail_cubit.dart';

class ScanTicketButton extends StatelessWidget {
  const ScanTicketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: WidgetPadding.paddingXL),
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (ctx, state) {
          final eventId = state.eventId;

          return CustomFilledButton(
            expanded: true,
            onPressedCallback: () async {
              await RouterFunc.goToScanTicketPage(
                context: context,
                eventId: eventId,
              );

              if (context.mounted) {
                await context.read<EventDetailCubit>().refresh();
              }
            },
            child: const Text(StringConst.scanTicket),
          );
        },
      ),
    );
  }
}
