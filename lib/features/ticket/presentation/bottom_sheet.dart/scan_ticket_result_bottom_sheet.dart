import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../domain/entities/ticket_entity.dart';

class ScanTicketResultBottomSheet extends StatelessWidget {
  final TicketEntity ticketEntity;
  final bool isSuccess;
  final String resultMessage;

  const ScanTicketResultBottomSheet({
    super.key,
    required this.ticketEntity,
    required this.isSuccess,
    required this.resultMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        isSuccess ? _buildSuccess(theme: theme) : _buildError(theme: theme),
      ],
    );
  }

  Widget _buildSuccess({required ThemeData theme}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // result
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(
                WidgetBorderRadius.border12,
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: WidgetPadding.paddingS,
                vertical: WidgetPadding.paddingL,
              ),
              child: Text(
                resultMessage,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacing.vertical(size: SpacingSize.l),

          Row(
            children: [
              const Text('${StringConst.ticketId}: '),
              Text(
                ticketEntity.ticketId,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          const Spacing.vertical(size: SpacingSize.m),

          Row(
            children: [
              const Text('${StringConst.ticketName}: '),
              Text(
                ticketEntity.ticketName,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          const Spacing.vertical(size: SpacingSize.m),

          Row(
            children: [
              const Text('${StringConst.guestName}: '),
              Text(
                ticketEntity.guest.guestName,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildError({required ThemeData theme}) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(
            WidgetBorderRadius.border12,
          ),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: WidgetPadding.paddingS,
            vertical: WidgetPadding.paddingL,
          ),
          child: Text(
            resultMessage,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
