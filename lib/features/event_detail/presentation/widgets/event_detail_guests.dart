import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/string_extension.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailGuests extends StatelessWidget {
  const EventDetailGuests({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (ctx, state) {
          final event = state.event;
          final guestsTotal = state.guestsTotal;
          final checkedInGuestsTotal = state.checkedInGuestsTotal;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WidgetPadding.paddingM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // indicator
                _buildCircularPercentIndicator(
                  context: context,
                  theme: theme,
                  event: event,
                  guestsTotal: guestsTotal,
                  checkedInGuestsTotal: checkedInGuestsTotal,
                ),
                const Spacing.horizontal(size: SpacingSize.l),

                // title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringConst.checkedIn,
                          style: theme.textTheme.titleMedium),
                      Text(
                        StringConst.checkedInDesc,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularPercentIndicator({
    required BuildContext context,
    required ThemeData theme,
    required EventEntity event,
    required int guestsTotal,
    required int checkedInGuestsTotal,
  }) {
    double radius = WidgetSize.s48;
    double lineWidth = WidgetSize.s10;

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: _getPercentage(
        guestsTotal: guestsTotal,
        checkedInGuestsTotal: checkedInGuestsTotal,
      ),
      center: FittedBox(
        child: Text(
          '$checkedInGuestsTotal/$guestsTotal',
          style: theme.textTheme.titleMedium,
        ),
      ),
      animation: true,
      animationDuration: WidgetAnimation.a1000,
      curve: Curves.ease,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: event.colorHex.convertToColor,
    );
  }

  double _getPercentage({
    required int guestsTotal,
    required int checkedInGuestsTotal,
  }) {
    if (checkedInGuestsTotal <= 0) {
      return 0;
    }

    return (checkedInGuestsTotal / guestsTotal);
  }
}
