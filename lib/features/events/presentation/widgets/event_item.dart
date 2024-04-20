import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/button/bouncing_button.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../core/presentation/widgets/image/custom_cached_network_image.dart';
import '../../../../utils/extenstions/date_extension.dart';
import '../../domain/entities/event_entity.dart';

class EventItem extends StatelessWidget {
  final EventEntity event;
  final void Function()? onTap;

  const EventItem({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _buildItem(theme: theme);
  }

  Widget _buildItem({required ThemeData theme}) {
    return _buildVerticalItem(theme: theme);
  }

  Widget _buildVerticalItem({required ThemeData theme}) {
    return BouncingButton(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(
            WidgetBorderRadius.border12,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            _buildImage(),
            const Spacing.vertical(size: SpacingSize.s),

            // event name
            _buildTitle(theme: theme),
            const Spacing.vertical(size: SpacingSize.xs),

            // event date
            _buildDate(theme: theme),
            const Spacing.vertical(size: SpacingSize.s),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      height: WidgetSize.s220,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(WidgetBorderRadius.border12),
          topRight: Radius.circular(WidgetBorderRadius.border12),
        ),
        // child: Image.asset(
        //   event.image,
        //   fit: BoxFit.cover,
        // ),
        child: CustomCachedNetworkImage(
          imageUrl: event.image,
        ),
      ),
    );
  }

  Widget _buildTitle({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.s),
        Expanded(
          child: Text(
            event.eventName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: theme.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildDate({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.s),
        Expanded(
          child: Text(
            event.date.formatDateWithTimeAndDay,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
