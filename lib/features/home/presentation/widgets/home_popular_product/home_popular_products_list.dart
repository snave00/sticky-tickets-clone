import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/icon/emoji_icon_widget.dart';
import '../../../../../core/presentation/widgets/placeholder/empty_state_text.dart';
import '../../../../../core/presentation/widgets/progress/custom_circular_progress.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/string_const.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../product/domain/entities/product_entity.dart';
import '../../../../product/presentation/widgets/item/product_item.dart';
import '../../../cubit/home_cubit.dart';

class HomePopularProductsList extends StatelessWidget {
  final List<ProductEntity> products;
  final HomeProductsStatus homeProductsStatus;

  const HomePopularProductsList({
    super.key,
    required this.products,
    required this.homeProductsStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (homeProductsStatus == HomeProductsStatus.getProductsLoading) {
      return _buildLoadingState();
    }

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    return _buildLoadedState(
      context: context,
      products: products,
    );
  }

  Widget _buildLoadedState({
    required BuildContext context,
    required List<ProductEntity> products,
  }) {
    return SizedBox(
      height: WidgetSize.s220,
      child: ListView.separated(
        separatorBuilder: (ctx, index) {
          return const Spacing.horizontal(size: SpacingSize.m);
        },
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: PagePadding.pagePadding - 3),
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          final productEntity = products[index];
          // final productId = productEntity.productId;

          return ProductItem(
            product: productEntity,
            productItemLayout: ProductItemLayout.horizontal,
            onTap: () async {
              // await RouterFunc.goToStoreDetailPage(
              //   context: context,
              //   storeId: storeId,
              // );
            },
          );
        },
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
          emptyStateText: StringConst.noProductsFound,
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
}
