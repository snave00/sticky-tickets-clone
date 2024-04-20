import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/icon/emoji_icon_widget.dart';
import '../../../../core/presentation/widgets/placeholder/empty_state_text.dart';
import '../../../../core/presentation/widgets/progress/custom_circular_progress.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../domain/entities/event_entity.dart';
import '../cubit/cubit/events_cubit.dart';
import 'event_item.dart';

class EventsSliverList extends StatelessWidget {
  const EventsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (ctx, state) {
        final events = state.events;
        final eventsStatus = state.eventsStatus;

        if (eventsStatus == EventsStatus.getEventsLoading) {
          return _buildLoadingState();
        }

        if (events.isEmpty) {
          return _buildEmptyState();
        }

        return _buildLoadedState(context: context, events: events);
      },
    );
  }

  Widget _buildLoadedState({
    required BuildContext context,
    required List<EventEntity> events,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: PagePadding.pagePadding,
      ),
      sliver: SliverList.separated(
        separatorBuilder: (ctx, index) {
          return const Spacing.vertical(size: SpacingSize.m);
        },
        itemCount: events.length,
        itemBuilder: (ctx, index) {
          final eventEntity = events[index];

          return EventItem(
            event: eventEntity,
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          EmptyStateText(
            emptyStateIcon: EmojiIconWidget(
              emoji: StringConst.emptyStateIcon,
              emojiSize: EmojiSize.medium,
            ),
            emptyStateText: StringConst.noEventsFound,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(WidgetPadding.paddingL),
        child: CustomCircularProgress(
          progressSize: ProgressSize.medium,
        ),
      ),
    );
  }
}
