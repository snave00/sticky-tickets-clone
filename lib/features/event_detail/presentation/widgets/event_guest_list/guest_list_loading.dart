import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';

class GuestListLoading extends StatelessWidget {
  const GuestListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetPadding.paddingM,
        vertical: WidgetPadding.paddingS,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _guestItemLoading(theme: theme),
            const Spacing.vertical(size: SpacingSize.m),
            _guestItemLoading(theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _guestItemLoading({required ThemeData theme}) {
    return Container(
      height: WidgetSize.s72,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(
        WidgetPadding.paddingM,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(
          WidgetBorderRadius.borderM,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: WidgetSize.s100,
            height: WidgetSize.s10,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(
                WidgetBorderRadius.border12,
              ),
            ),
          ),
          const Spacing.vertical(size: SpacingSize.s),
          Container(
            width: WidgetSize.s60,
            height: WidgetSize.s8,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(
                WidgetBorderRadius.border12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
