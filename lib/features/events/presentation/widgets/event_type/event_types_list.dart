import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../../utils/enums/event_type_enum.dart';
import '../../cubit/cubit/events_cubit.dart';
import 'event_type_item.dart';

class EventTypesList extends StatelessWidget {
  final EventType selectedEventType;

  const EventTypesList({
    super.key,
    required this.selectedEventType,
  });

  @override
  Widget build(BuildContext context) {
    return _buildLoadedState(context: context);
  }

  Widget _buildLoadedState({required BuildContext context}) {
    const eventTypes = EventType.values;

    return SizedBox(
      height: WidgetSize.s42,
      child: Center(
        child: ListView.separated(
          separatorBuilder: (ctx, index) {
            return const Spacing.horizontal(size: SpacingSize.m);
          },
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: PagePadding.pagePadding,
          ),
          itemCount: eventTypes.length,
          itemBuilder: (ctx, index) {
            final eventType = eventTypes[index];
            final isSelected = selectedEventType == eventType;

            return EventTypeItem(
              title: eventType.title,
              iconData: eventType.iconData,
              isSelected: isSelected,
              onTap: () async {
                await context.read<EventsCubit>().selectEventType(
                      eventType: eventType,
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
