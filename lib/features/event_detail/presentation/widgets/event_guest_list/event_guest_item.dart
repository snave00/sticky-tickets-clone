import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/string_const.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../../utils/extenstions/date_extension.dart';

class EventGuestItem extends StatelessWidget {
  final String guestName;
  final bool isScanned;
  final DateTime scannedAt;

  const EventGuestItem({
    super.key,
    required this.guestName,
    required this.isScanned,
    required this.scannedAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(
          WidgetBorderRadius.borderM,
        ),
      ),
      child: ListTile(
        title: Text(
          guestName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
        subtitle: isScanned
            ? Text(
                '${StringConst.checkedIn}: ${scannedAt.formatDateShortTime}',
                style: theme.textTheme.bodySmall,
              )
            : Text(
                StringConst.guestHaveNotCheckedIn,
                style: theme.textTheme.bodySmall,
              ),
        trailing: isScanned
            ? const FaIcon(
                FontAwesomeIcons.check,
                color: Colors.greenAccent,
              )
            : const FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.amber,
              ),
      ),
    );
  }
}
