import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/product_category_entity.dart';
import '../repositories/product_repo.dart';

class GetProductCategoriesUseCase
    implements UseCase<List<ProductCategoryEntity>, NoParams> {
  final ProductRepo productRepo;

  GetProductCategoriesUseCase({required this.productRepo});

  @override
  Future<Either<Failure, List<ProductCategoryEntity>>> call(
      NoParams noParams) async {
    return await productRepo.getProductCategories();
  }
}
