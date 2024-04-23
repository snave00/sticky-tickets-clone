import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/string_extension.dart';
import '../cubit/cubit/events_cubit.dart';

class EventScaffold extends StatelessWidget {
  final Widget body;
  const EventScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EventsCubit, EventsState>(
      builder: (ctx, state) {
        final events = state.events;
        final selectedEventIndex = state.selectedEventIndex;
        String colorHex = '';
        if (events.isNotEmpty) {
          colorHex = events[selectedEventIndex].colorHex;
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: WidgetAnimation.a500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getTopColor(
                    theme: theme,
                    topColorHex: colorHex,
                  ),
                  _getBottomColor(
                    theme: theme,
                    topColorHex: colorHex,
                  ),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: body,
          ),
        );
      },
    );
  }

  Color _getTopColor({
    required ThemeData theme,
    required String topColorHex,
  }) {
    if (topColorHex.isNotEmpty) {
      return topColorHex.convertToColor;
    }

    return theme.colorScheme.background;
  }

  Color _getBottomColor({
    required ThemeData theme,
    required String topColorHex,
  }) {
    if (topColorHex.isNotEmpty) {
      return Colors.black;
    }

    return theme.colorScheme.background;
  }
}
