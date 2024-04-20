import 'package:flutter/material.dart';

import '../../../../utils/constants/string_const.dart';

class EventSliverAppBar extends StatelessWidget {
  const EventSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      title: Column(
        children: [
          // date
          Text(StringConst.events),
          // title
          Text(StringConst.events)
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
    );
  }
}
