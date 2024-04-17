import 'package:flutter/material.dart';

import '../../../../../utils/constants/string_const.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../product/domain/entities/product_entity.dart';
import 'home_popular_products_view_all.dart';

class HomePopularProductsTitle extends StatelessWidget {
  final List<ProductEntity> products;

  const HomePopularProductsTitle({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: PagePadding.pagePadding,
        right: WidgetPadding.paddingM,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              StringConst.popular,
              style: theme.textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          HomePopularProductsViewAll(products: products),
        ],
      ),
    );
  }
}
