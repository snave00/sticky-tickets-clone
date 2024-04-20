import 'package:flutter/material.dart';

import '../../../../utils/constants/string_const.dart';
import '../../../../utils/extenstions/date_extension.dart';

class EventSliverAppBar extends StatelessWidget {
  const EventSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // date
          Text(
            DateTime.now().formatDateDayMonth.toString().toUpperCase(),
            style: theme.textTheme.bodyMedium,
          ),

          // title
          Text(
            StringConst.events,
            style: theme.textTheme.headlineLarge,
          )
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
    );
  }
}
