import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/icon/emoji_icon_widget.dart';
import '../../../../../core/presentation/widgets/placeholder/empty_state_text.dart';
import '../../../../../core/presentation/widgets/progress/custom_circular_progress.dart';
import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../../utils/constants/string_const.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../../utils/helpers/product/product_helper.dart';
import '../../../../product/domain/entities/product_category_entity.dart';
import '../../../../product/presentation/widgets/item/product_category_item.dart';
import '../../../cubit/home_cubit.dart';

class HomeProductCategoriesList extends StatelessWidget {
  final List<ProductCategoryEntity> productCategories;
  final HomeProductCategoriesStatus homeProductCategoriesStatus;
  final String selectedProductCategoryId;

  const HomeProductCategoriesList({
    super.key,
    required this.productCategories,
    required this.homeProductCategoriesStatus,
    required this.selectedProductCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    if (homeProductCategoriesStatus ==
        HomeProductCategoriesStatus.getProductCategoriesLoading) {
      return _buildLoadingState();
    }

    if (productCategories.isEmpty) {
      return _buildEmptyState();
    }

    return _buildLoadedState(context: context);
  }

  Widget _buildLoadedState({required BuildContext context}) {
    final withAllProductCategories = addAllCategory(
      productCategories: productCategories,
    );
    return SizedBox(
      height: WidgetSize.s42,
      child: Center(
        child: ListView.separated(
          separatorBuilder: (ctx, index) {
            return const Spacing.horizontal(size: SpacingSize.m);
          },
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: PagePadding.pagePadding - 3,
          ),
          itemCount: withAllProductCategories.length,
          itemBuilder: (ctx, index) {
            final productCategoryEntity = withAllProductCategories[index];
            final isSelected = selectedProductCategoryId ==
                productCategoryEntity.productCategoryId;

            return ProductCategoryItem(
              title: productCategoryEntity.productCategoryName,
              imagePath: productCategoryEntity.image,
              isSelected: isSelected,
              onTap: () {
                context.read<HomeCubit>().selectProductCategory(
                      productCategoryId:
                          productCategoryEntity.productCategoryId,
                    );
              },
            );
          },
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
          emptyStateText: StringConst.noCategoriesFound,
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
