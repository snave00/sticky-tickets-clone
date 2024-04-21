import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/date_extension.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailVenueDate extends StatelessWidget {
  const EventDetailVenueDate({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (ctx, state) {
          final event = state.event;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WidgetPadding.paddingM + 4,
              vertical: WidgetPadding.paddingS,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // venue
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.mapPin,
                      size: WidgetSize.s12,
                    ),
                    const Spacing.horizontal(size: SpacingSize.s),
                    Text(event.venue),
                  ],
                ),
                const Spacing.vertical(size: SpacingSize.xs),

                // date
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      size: WidgetSize.s12,
                    ),
                    const Spacing.horizontal(size: SpacingSize.s),
                    Text(event.date.formatDateWithTimeAndDay),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
