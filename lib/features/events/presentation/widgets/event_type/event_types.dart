import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit/events_cubit.dart';
import 'event_types_list.dart';

class EventTypes extends StatelessWidget {
  const EventTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<EventsCubit, EventsState>(
        builder: (ctx, state) {
          final selectedEventType = state.eventType;

          return EventTypesList(selectedEventType: selectedEventType);
        },
      ),
    );
  }
}
