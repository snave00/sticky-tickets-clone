import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/scaffold/gradient_scaffold.dart';
import '../cubit/cubit/events_cubit.dart';

class EventScaffold extends StatelessWidget {
  final Widget body;
  const EventScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (ctx, state) {
        final events = state.events;
        final selectedEventIndex = state.selectedEventIndex;
        String colorHex = '';
        if (events.isNotEmpty) {
          colorHex = events[selectedEventIndex].colorHex;
        }

        return GradientScaffold(
          topColor: colorHex,
          body: body,
        );
      },
    );
  }
}
