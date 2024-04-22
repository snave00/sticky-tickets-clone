import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/date_extension.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailVenueDate extends StatelessWidget {
  const EventDetailVenueDate({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (ctx, state) {
          final event = state.event;
          final venue = event.venue;
          final dateTime = event.date.formatDateShortTime;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WidgetPadding.paddingM,
              vertical: WidgetPadding.paddingS,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // venue
                    _buildVenue(theme: theme, venue: venue),
                    const Spacing.vertical(size: SpacingSize.xs),

                    // date
                    _buildDate(theme: theme, dateTime: dateTime),
                  ],
                ),
                const Spacing.vertical(size: SpacingSize.s),
                const Divider(thickness: 0.3),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVenue({
    required ThemeData theme,
    required String venue,
  }) {
    return Row(
      children: [
        _buildIcon(
          theme: theme,
          iconData: FontAwesomeIcons.locationDot,
        ),
        const Spacing.horizontal(size: SpacingSize.s),

        // venue name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConst.venue,
              style: theme.textTheme.bodySmall,
            ),
            Text(
              venue,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDate({
    required ThemeData theme,
    required String dateTime,
  }) {
    return Row(
      children: [
        _buildIcon(
          theme: theme,
          iconData: FontAwesomeIcons.solidClock,
        ),
        const Spacing.horizontal(size: SpacingSize.s),

        // date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConst.date,
              style: theme.textTheme.bodySmall,
            ),
            Text(
              dateTime,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildIcon({
    required ThemeData theme,
    required IconData iconData,
  }) {
    return Container(
      width: WidgetSize.s40,
      height: WidgetSize.s40,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(
          WidgetBorderRadius.border12,
        ),
      ),
      alignment: Alignment.center,
      child: FaIcon(
        iconData,
        size: WidgetSize.s12,
      ),
    );
  }
}
