import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/gesture/hide_keyboard_on_tap.dart';
import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../cubit/home_cubit.dart';
import '../widgets/home_app_bar/home_app_bar.dart';
import '../widgets/home_popular_product/home_popular_products.dart';
import '../widgets/home_product_categories/home_product_categories.dart';
import '../widgets/home_promo.dart/home_promos.dart';
import '../widgets/home_search/home_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HideKeyboardOnTap(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: SafeArea(
          child: CustomPullRefresh(
            onRefresh: () async {
              return context.read<HomeCubit>().init();
            },
            child: const CustomScrollView(
              slivers: [
                // search bar
                HomeSearch(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                // categories
                HomeProductCategories(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                // popular products
                HomePopularProducts(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),

                // promos
                HomePromos(),
                Spacing.vertical(size: SpacingSize.l, isSliver: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
