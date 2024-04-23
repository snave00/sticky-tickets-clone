import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/appbar/custom_sliver_app_bar.dart';
import '../../../../core/presentation/widgets/icon/emoji_icon_widget.dart';
import '../../../../core/presentation/widgets/placeholder/empty_state_text.dart';
import '../../../../core/presentation/widgets/progress/custom_circular_progress.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailAppBar extends StatelessWidget {
  const EventDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double currentAppBarHeight = 0.0;
    final paddingTop = MediaQuery.of(context).padding.top;
    final collapsedAppBarHeight = paddingTop + kToolbarHeight;
    const expandedHeight = WidgetSize.s300;
    final expandedHeightWithTopPad = paddingTop + expandedHeight;

    return CustomSliverAppBar(
      hasBackButton: true,
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (ctx, constraints) {
          currentAppBarHeight = constraints.biggest.height;

          final expandedOpacity = _getExpandedOpacity(
            currentAppBarHeight: currentAppBarHeight,
            expandedHeightWithTopPad: expandedHeightWithTopPad,
          );
          final collapsedOpacity = _getCollapsedOpacity(
            currentAppBarHeight: currentAppBarHeight,
            collapsedAppBarHeight: collapsedAppBarHeight,
          );
          final collapsed = currentAppBarHeight == collapsedAppBarHeight;

          return BlocBuilder<EventDetailCubit, EventDetailState>(
            builder: (ctx, state) {
              final event = state.event;
              final eventDetailStatus = state.eventDetailStatus;

              if (eventDetailStatus == EventDetailStatus.loading) {
                return _buildLoadingState();
              }

              if (event == EventEntity.empty()) {
                return _buildEmptyState();
              }

              return _buildLoadedState(
                theme: theme,
                event: event,
                collapsed: collapsed,
                collapsedOpacity: collapsedOpacity,
                expandedOpacity: expandedOpacity,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadedState({
    required ThemeData theme,
    required EventEntity event,
    required bool collapsed,
    required double collapsedOpacity,
    required double expandedOpacity,
  }) {
    return FlexibleSpaceBar(
      centerTitle: collapsed,
      titlePadding: EdgeInsets.symmetric(
        vertical: collapsed ? WidgetPadding.paddingM : WidgetPadding.paddingS,
        horizontal: WidgetPadding.paddingM,
      ),
      title: collapsed
          ? _buildCollapsedTitle(
              theme: theme,
              eventName: event.eventName,
              collapsedOpacity: collapsedOpacity,
            )
          : _buildExpandedTitle(
              theme: theme,
              eventName: event.eventName,
              expandedOpacity: expandedOpacity,
            ),
      background: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.black12,
          BlendMode.softLight,
        ),
        child: Stack(
          children: [
            // image
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: event.image,
                fit: BoxFit.cover,
              ),
            ),

            // overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: WidgetSize.s48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      theme.colorScheme.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Column(
      children: [
        EmptyStateText(
          emptyStateIcon: EmojiIconWidget(
            emoji: StringConst.emptyStateIcon,
            emojiSize: EmojiSize.medium,
          ),
          emptyStateText: StringConst.noEventFound,
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(WidgetPadding.paddingL),
      child: CustomCircularProgress(
        progressSize: ProgressSize.medium,
      ),
    );
  }

  Widget _buildCollapsedTitle({
    required ThemeData theme,
    required double collapsedOpacity,
    required String eventName,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: WidgetAnimation.a300),
      opacity: collapsedOpacity,
      child: Text(
        eventName,
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  Widget _buildExpandedTitle({
    required ThemeData theme,
    required double expandedOpacity,
    required String eventName,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: WidgetAnimation.a300),
      opacity: expandedOpacity,
      child: Text(
        eventName,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onBackground.withOpacity(0.9),
        ),
      ),
    );
  }

  double _getExpandedOpacity({
    required double currentAppBarHeight,
    required double expandedHeightWithTopPad,
  }) {
    final expandedPercentage = (currentAppBarHeight / expandedHeightWithTopPad);
    if (expandedPercentage <= 0.5) {
      return 0;
    }

    if (expandedPercentage > 1) {
      return 1;
    }

    if (expandedPercentage < 0) {
      return 0;
    }
    return expandedPercentage;
  }

  double _getCollapsedOpacity({
    required double currentAppBarHeight,
    required double collapsedAppBarHeight,
  }) {
    if (currentAppBarHeight >= collapsedAppBarHeight) {
      return 1;
    }

    if (currentAppBarHeight < collapsedAppBarHeight) {
      return 0;
    }

    return 0;
  }
}
