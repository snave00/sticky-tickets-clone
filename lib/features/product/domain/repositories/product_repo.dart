import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../entities/product_category_entity.dart';
import '../entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required String productCategoryId,
    bool isPopular = false,
  });

  Future<Either<Failure, ProductEntity>> getProduct({
    required String productId,
  });

  Future<Either<Failure, List<ProductCategoryEntity>>> getProductCategories();
}
