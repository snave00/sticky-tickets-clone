import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/presentation/widgets/button/bouncing_button.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';

class EventTypeItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isSelected;
  final void Function()? onTap;

  const EventTypeItem({
    super.key,
    required this.title,
    required this.iconData,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BouncingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: WidgetPadding.paddingM),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.surfaceVariant
              : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(WidgetBorderRadius.borderXL),
          ),
        ),
        child: Row(
          children: [
            // icon
            FaIcon(iconData, size: WidgetSize.s12),
            const Spacing.horizontal(size: SpacingSize.s),

            // title
            Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
