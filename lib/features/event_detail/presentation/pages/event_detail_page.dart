import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/button/custom_filled_button.dart';
import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../cubit/event_detail_cubit.dart';
import '../widgets/event_detail_app_bar.dart';
import '../widgets/event_detail_guests_total.dart';
import '../widgets/event_detail_scaffold.dart';
import '../widgets/event_detail_venue_date.dart';
import '../widgets/event_guest_list/event_detail_guest_list.dart';
import '../widgets/event_guest_list/event_guest_title.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventDetailScaffold(
      body: CustomPullRefresh(
        onRefresh: () async {
          await context.read<EventDetailCubit>().refresh();
          return;
        },
        child: const CustomScrollView(
          slivers: [
            // app bar
            EventDetailAppBar(),

            // venue and date
            EventDetailVenueDate(),
            Spacing.vertical(size: SpacingSize.m, isSliver: true),

            // guest count
            EventDetailGuestsTotal(),
            Spacing.vertical(size: SpacingSize.m, isSliver: true),

            // guests list
            EventGuestTitle(),
            EventDetailGuestList(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: WidgetPadding.paddingXL),
        child: CustomFilledButton(
          expanded: true,
          onPressedCallback: () {},
          child: const Text(StringConst.scanTicket),
        ),
      ),
    );
  }
}
