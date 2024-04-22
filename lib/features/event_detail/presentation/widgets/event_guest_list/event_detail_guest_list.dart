import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/widgets/icon/emoji_icon_widget.dart';
import '../../../../../../core/presentation/widgets/placeholder/empty_state_text.dart';
import '../../../../../../core/presentation/widgets/progress/custom_circular_progress.dart';
import '../../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../../utils/constants/string_const.dart';
import '../../../../../../utils/constants/widget_const.dart';
import '../../../../events/domain/entities/ticket_entity.dart';
import '../../cubit/event_detail_cubit.dart';
import 'event_guest_item.dart';

class EventDetailGuestList extends StatelessWidget {
  const EventDetailGuestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailCubit, EventDetailState>(
      builder: (ctx, state) {
        final guestList = state.filteredTickets;
        final ticketsStatus = state.getTicketsStatus;

        if (ticketsStatus == GetTicketsStatus.loading) {
          return _buildLoadingState();
        }

        if (guestList.isEmpty) {
          return _buildEmptyState();
        }

        return _buildLoadedState(context: context, guestList: guestList);
      },
    );
  }

  Widget _buildLoadedState({
    required BuildContext context,
    required List<TicketEntity> guestList,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: PagePadding.pagePadding,
      ),
      sliver: SliverList.separated(
        separatorBuilder: (ctx, index) {
          return const Spacing.vertical(size: SpacingSize.m);
        },
        itemCount: guestList.length,
        itemBuilder: (ctx, index) {
          final guest = guestList[index].guest;
          final scannedAt = guestList[index].scannedAt;
          final isScanned = guestList[index].isScanned;

          return EventGuestItem(
            guestName: guest.guestName,
            scannedAt: scannedAt,
            isScanned: isScanned,
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
            emptyStateText: StringConst.noGuestsFound,
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
