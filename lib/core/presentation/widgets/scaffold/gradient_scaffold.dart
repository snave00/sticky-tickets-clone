import 'package:flutter/material.dart';

import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/extenstions/string_extension.dart';

class GradientScaffold extends StatelessWidget {
  final String topColor;
  final Widget body;
  const GradientScaffold({
    super.key,
    required this.topColor,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: WidgetAnimation.a500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getTopColor(theme: theme),
              _getBottomColor(theme: theme),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: body,
      ),
    );
  }

  Color _getTopColor({required ThemeData theme}) {
    if (topColor.isNotEmpty) {
      return topColor.convertToColor;
    }

    return theme.colorScheme.background;
  }

  Color _getBottomColor({required ThemeData theme}) {
    if (topColor.isNotEmpty) {
      return Colors.black;
    }

    return theme.colorScheme.background;
  }
}
