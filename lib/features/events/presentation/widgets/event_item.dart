import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/presentation/widgets/button/bouncing_button.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../core/presentation/widgets/image/custom_cached_network_image.dart';
import '../../../../utils/constants/string_const.dart';
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
      child: Stack(
        children: [
          // image
          _buildImage(),

          // event name and details
          _buildDetails(theme: theme),

          _buildDate(theme: theme),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      height: WidgetSize.s400,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(WidgetBorderRadius.borderM),
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

  Widget _buildDetails({required ThemeData theme}) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(WidgetBorderRadius.borderM),
            bottomRight: Radius.circular(WidgetBorderRadius.borderM),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black87,
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing.vertical(size: SpacingSize.s),

            // event name
            _buildTitle(theme: theme),
            const Spacing.vertical(size: SpacingSize.xs),

            // event venue and guests count
            _buildVenueAndGuests(theme: theme),
            const Spacing.vertical(size: SpacingSize.m),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.m),
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

  Widget _buildVenueAndGuests({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.m),

        // venue
        _buildVenue(theme: theme),

        // guests count
        _buildGuests(theme: theme),
        const Spacing.horizontal(size: SpacingSize.m),
      ],
    );
  }

  Widget _buildVenue({required ThemeData theme}) {
    return Expanded(
      child: Row(
        children: [
          // pin icon
          const FaIcon(
            FontAwesomeIcons.mapPin,
            size: WidgetSize.s12,
          ),
          const Spacing.horizontal(size: SpacingSize.s),

          // venue
          Text(
            event.venue,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildGuests({required ThemeData theme}) {
    return Row(
      children: [
        // guest icon
        const FaIcon(
          FontAwesomeIcons.user,
          size: WidgetSize.s12,
        ),
        const Spacing.horizontal(size: SpacingSize.s),

        // venue
        Text(
          '${event.guestTotal} ${StringConst.guests}',
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildDate({required ThemeData theme}) {
    return Positioned(
      top: WidgetMargin.marginM,
      right: WidgetMargin.marginM,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WidgetPadding.paddingM,
          vertical: WidgetPadding.paddingS,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(
            WidgetBorderRadius.border12,
          ),
        ),
        child: Column(
          children: [
            // day
            Text(
              DateFormat.d().format(event.date),
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.black87,
              ),
            ),

            // month
            Text(
              DateFormat.LLL().format(event.date).toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
