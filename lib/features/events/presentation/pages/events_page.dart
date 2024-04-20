import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/gesture/hide_keyboard_on_tap.dart';
import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../cubit/cubit/events_cubit.dart';
import '../widgets/event_scaffold.dart';
import '../widgets/event_search.dart';
import '../widgets/event_sliver_app_bar.dart';
import '../widgets/events_sliver_list.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboardOnTap(
      child: EventScaffold(
        body: SafeArea(
          child: CustomPullRefresh(
            onRefresh: () async {
              return context.read<EventsCubit>().init();
            },
            child: CustomScrollView(
              controller: _controller,
              slivers: const [
                Spacing.vertical(size: SpacingSize.s, isSliver: true),

                // app bar
                EventSliverAppBar(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                // search bar
                EventSearch(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                //  events list
                EventsSliverList(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                SliverFillRemaining(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    final topIndex = (_controller.offset / 300).floor();
    context.read<EventsCubit>().setSelectedEventIndex(index: topIndex);
  }
}
