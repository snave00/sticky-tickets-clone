import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/home_cubit.dart';
import 'home_product_categories_list.dart';

class HomeProductCategories extends StatelessWidget {
  const HomeProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          final productCategories = state.productCategories;
          final homeProductCategoriesStatus = state.homeProductCategoriesStatus;
          final selectedProductCategoryId = state.selectedProductCategoryId;

          return HomeProductCategoriesList(
            productCategories: productCategories,
            homeProductCategoriesStatus: homeProductCategoriesStatus,
            selectedProductCategoryId: selectedProductCategoryId,
          );
        },
      ),
    );
  }
}
