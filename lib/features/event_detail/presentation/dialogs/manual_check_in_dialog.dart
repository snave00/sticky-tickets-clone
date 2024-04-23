import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/button/custom_text_button.dart';
import '../../../../core/presentation/widgets/dialog/custom_alert_dialog.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../ticket/domain/entities/ticket_entity.dart';

class ManualCheckInDialog extends StatelessWidget {
  final bool isNotCheckedIn;
  final TicketEntity ticketEntity;
  final void Function()? onYesPressed;

  const ManualCheckInDialog({
    super.key,
    required this.isNotCheckedIn,
    required this.ticketEntity,
    this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAlertDialog(
      icon: FaIcon(
        FontAwesomeIcons.triangleExclamation,
        color: theme.colorScheme.error,
      ),
      title: isNotCheckedIn
          ? StringConst.manualCheckInGuest
          : StringConst.manualCheckOutGuest,
      content:
          '${ticketEntity.ticketId}\n${ticketEntity.ticketName}\n${ticketEntity.guest.guestName}',
      actions: [
        Expanded(
          child: CustomTextButton(
            onPressedCallback: onYesPressed,
            child: const Text(StringConst.yes),
          ),
        ),
        Expanded(
          child: CustomTextButton(
            onPressedCallback: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: theme.textTheme.bodyMedium?.color,
            ),
            child: const Text(StringConst.no),
          ),
        ),
      ],
    );
  }
}
