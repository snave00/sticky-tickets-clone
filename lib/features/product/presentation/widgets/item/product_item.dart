import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/button/add_to_cart_icon_button.dart';
import '../../../../../core/presentation/widgets/button/bouncing_button.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../domain/entities/product_entity.dart';

enum ProductItemLayout {
  horizontal,
  vertical,
}

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final ProductItemLayout productItemLayout;
  final void Function()? onTap;
  final void Function()? onAddTap;

  const ProductItem({
    super.key,
    required this.product,
    required this.productItemLayout,
    this.onTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _buildItem(theme: theme);
  }

  Widget _buildItem({required ThemeData theme}) {
    if (_isHorizontal()) {
      return _buildHorizontalLayout(theme: theme);
    }

    return _buildVerticalItem(theme: theme);
  }

  Widget _buildHorizontalLayout({required ThemeData theme}) {
    return SizedBox(
      width: WidgetSize.s180,
      child: Stack(
        children: [
          BouncingButton(
            onTap: onTap,
            child: Column(
              children: [
                // image
                _buildImage(),
                const Spacing.vertical(size: SpacingSize.s),

                // product name
                _buildTitle(theme: theme),

                // desc
                _buildDesc(theme: theme),
                const Spacing.vertical(size: SpacingSize.xs),

                // price
                _buildPrice(theme: theme),
                const Spacing.vertical(size: SpacingSize.s),
              ],
            ),
          ),

          // add button
          Positioned(
            top: WidgetSize.s100,
            right: WidgetPadding.paddingXS,
            child: AddToCartIconButton(
              onTap: onAddTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalItem({required ThemeData theme}) {
    return Stack(
      children: [
        BouncingButton(
          onTap: onTap,
          child: Column(
            children: [
              // image & add button -> stack
              Stack(
                children: [
                  _buildImage(),
                ],
              ),
              const Spacing.vertical(size: SpacingSize.s),

              // product name
              _buildTitle(theme: theme),

              // desc
              _buildDesc(theme: theme),
              const Spacing.vertical(size: SpacingSize.xs),

              // price
              _buildPrice(theme: theme),
              const Spacing.vertical(size: SpacingSize.s),
            ],
          ),
        ),

        // add button
        Positioned(
          top: WidgetSize.s100,
          right: WidgetPadding.paddingXS,
          child: AddToCartIconButton(
            onTap: onAddTap,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      height: WidgetSize.s140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          WidgetBorderRadius.border12,
        ),
        child: Image.asset(
          product.productImage,
          fit: BoxFit.cover,
        ),
        // child: CustomCachedNetworkImage(
        //   imageUrl: product.productImage,
        // ),
      ),
    );
  }

  Widget _buildTitle({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.xs),
        Expanded(
          child: Text(
            product.productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildDesc({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.xs),
        Expanded(
          child: Text(
            product.productDesc,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice({required ThemeData theme}) {
    return Row(
      children: [
        const Spacing.horizontal(size: SpacingSize.xs),
        Expanded(
          child: Text(
            product.productPrice,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  bool _isHorizontal() {
    return productItemLayout == ProductItemLayout.horizontal;
  }
}
