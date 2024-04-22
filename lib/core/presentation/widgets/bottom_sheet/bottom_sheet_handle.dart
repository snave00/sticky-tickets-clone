import 'package:flutter/material.dart';

import '../../../../utils/constants/widget_const.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: WidgetMargin.marginM),
          height: WidgetSize.s5,
          width: WidgetSize.s48,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(WidgetSize.s5 / 2),
          ),
        ),
        const SizedBox(height: WidgetMargin.marginXL),
      ],
    );
  }
}
