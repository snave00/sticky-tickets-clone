import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../cubit/home_cubit.dart';
import 'home_popular_products_list.dart';
import 'home_popular_products_title.dart';

class HomePopularProducts extends StatelessWidget {
  const HomePopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          final products = state.products;
          final homeProductsStatus = state.homeProductsStatus;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              HomePopularProductsTitle(products: products),
              const Spacing.vertical(size: SpacingSize.s),

              // list
              HomePopularProductsList(
                products: products,
                homeProductsStatus: homeProductsStatus,
              ),
            ],
          );
        },
      ),
    );
  }
}
