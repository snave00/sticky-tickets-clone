import 'package:flutter/material.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';

import '../../../../../utils/constants/string_const.dart';
import '../../../../../utils/constants/widget_const.dart';

class EventGuestTitle extends StatelessWidget {
  const EventGuestTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PagePadding.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConst.guestList, style: theme.textTheme.titleLarge),
            const Spacing.vertical(size: SpacingSize.s),
          ],
        ),
      ),
    );
  }
}
