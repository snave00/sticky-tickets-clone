import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/button/view_all_button.dart';
import '../../../../product/domain/entities/product_entity.dart';

class HomePopularProductsViewAll extends StatelessWidget {
  final List<ProductEntity> products;

  const HomePopularProductsViewAll({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isNotEmpty) {
      return ViewAllButton(
        onTap: () async {
          await _goToAllProductsPage(context: context);
        },
      );
    }

    return Container();
  }

  Future<void> _goToAllProductsPage({required BuildContext context}) async {
    // await RouterFunctions.goToBudgetPage(
    //   context: context,
    //   isFromSetup: false,
    // );
  }
}
