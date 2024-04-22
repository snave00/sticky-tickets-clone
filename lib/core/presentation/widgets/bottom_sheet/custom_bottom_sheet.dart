import 'package:flutter/material.dart';

import '../../../../utils/constants/widget_const.dart';
import 'bottom_sheet_handle.dart';

class CustomBottomSheet extends StatelessWidget {
  final bool? expand;
  final double? initialChildSize;
  final double? maxChildSize;
  final bool? hasScrollBar;
  // * Put null if you don't want to make it draggable
  final Widget Function(
    ScrollController? scrollController,
  ) scrollView;

  const CustomBottomSheet({
    super.key,
    this.expand,
    this.initialChildSize,
    this.maxChildSize,
    this.hasScrollBar = false,
    required this.scrollView,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: expand ?? false,
      initialChildSize: initialChildSize ?? 0.55, // depends on child widgets
      maxChildSize: maxChildSize ?? 0.9,
      builder: (ctx, scrollController) => Column(
        children: [
          // handle
          const BottomSheetHandle(),

          // child content
          Expanded(
            child: (hasScrollBar ?? false)
                ? _buildChildWithScrollBar(
                    scrollController: scrollController,
                  )
                : _buildChildContent(
                    scrollController: scrollController,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildWithScrollBar({
    required ScrollController scrollController,
  }) {
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: _buildChildContent(
        scrollController: scrollController,
      ),
    );
  }

  Widget _buildChildContent({required ScrollController scrollController}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: WidgetPadding.paddingL,
        right: WidgetPadding.paddingL,
      ),
      child: scrollView(scrollController),
    );
  }
}
