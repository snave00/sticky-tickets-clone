import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../params/products_params.dart';
import '../repositories/product_repo.dart';

class GetProductsUseCase
    implements UseCase<List<ProductEntity>, ProductParams> {
  final ProductRepo productRepo;

  GetProductsUseCase({required this.productRepo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    ProductParams params,
  ) async {
    return await productRepo.getProducts(
      productCategoryId: params.productCategoryId ?? '',
      isPopular: params.isPopular ?? false,
    );
  }
}
