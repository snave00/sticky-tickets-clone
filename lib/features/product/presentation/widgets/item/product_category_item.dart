import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/button/bouncing_button.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';

class ProductCategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final void Function()? onTap;

  const ProductCategoryItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BouncingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: WidgetPadding.paddingM),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(WidgetBorderRadius.borderXL),
          ),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : theme.colorScheme.onBackground,
                BlendMode.srcATop,
              ),
              child: Image(
                image: AssetImage(imagePath),
                width: WidgetSize.s16,
              ),
            ),
            const Spacing.horizontal(size: SpacingSize.s),

            // category name
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
