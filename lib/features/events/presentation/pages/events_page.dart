import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../cubit/cubit/events_cubit.dart';
import '../widgets/event_sliver_app_bar.dart';
import '../widgets/events_sliver_list.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPullRefresh(
          onRefresh: () async {
            return context.read<EventsCubit>().init();
          },
          child: const CustomScrollView(
            slivers: [
              // app bar
              // EventSliverAppBar(),
              // search bar
              // HomeSearch(),
              Spacing.vertical(size: SpacingSize.l, isSliver: true),

              //  events list
              EventsSliverList(),
              Spacing.vertical(size: SpacingSize.l, isSliver: true),
            ],
          ),
        ),
      ),
    );
  }
}
