import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';

class VenueDateLoading extends StatelessWidget {
  const VenueDateLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetPadding.paddingM,
        vertical: WidgetPadding.paddingS,
      ),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildVenueDateLoading(theme: theme),
                _buildVenueDateLoading(theme: theme),
              ],
            ),
          ),
          const Spacing.vertical(size: SpacingSize.s),
          const Divider(thickness: 0.3),
        ],
      ),
    );
  }

  Widget _buildVenueDateLoading({required ThemeData theme}) {
    return Row(
      children: [
        // icon loading
        Container(
          width: WidgetSize.s40,
          height: WidgetSize.s40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(
              WidgetBorderRadius.border12,
            ),
          ),
        ),
        const Spacing.horizontal(size: SpacingSize.s),

        // subtitle loading
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(
                  WidgetBorderRadius.borderXS,
                ),
              ),
              height: WidgetSize.s10,
              width: WidgetSize.s60,
            ),
            const Spacing.vertical(size: SpacingSize.s),

            // subtitle
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(
                  WidgetBorderRadius.borderXS,
                ),
              ),
              height: WidgetSize.s10,
              width: WidgetSize.s60,
            ),
          ],
        )
      ],
    );
  }
}
