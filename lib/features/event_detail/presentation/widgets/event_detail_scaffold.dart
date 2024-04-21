import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/string_extension.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailScaffold extends StatelessWidget {
  final Widget body;
  const EventDetailScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EventDetailCubit, EventDetailState>(
      builder: (ctx, state) {
        final event = state.event;
        String colorHex = '';

        if (event.colorHex.isNotEmpty) {
          colorHex = event.colorHex;
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: WidgetAnimation.a500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.background,
                  _getBottomColor(theme: theme, colorHex: colorHex),
                ],
                begin: Alignment.center,
                end: Alignment.bottomRight,
              ),
            ),
            child: body,
          ),
        );
      },
    );
  }

  Color _getBottomColor({
    required ThemeData theme,
    required String colorHex,
  }) {
    if (colorHex.isNotEmpty) {
      return colorHex.convertToColor;
    }

    return theme.colorScheme.background;
  }
}
