import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../cubit/event_detail_cubit.dart';
import '../widgets/event_detail_app_bar.dart';
import '../widgets/event_detail_scaffold.dart';
import '../widgets/event_detail_venue_date.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventDetailScaffold(
      body: CustomPullRefresh(
        onRefresh: () async {
          return context.read<EventDetailCubit>().getEvent();
        },
        child: const CustomScrollView(
          slivers: [
            // app bar
            EventDetailAppBar(),

            // venue and date
            EventDetailVenueDate(),

            // guest count

            // guest list
          ],
        ),
      ),
    );
  }
}
