import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repo.dart';

class GetProductUseCase implements UseCase<ProductEntity, String> {
  final ProductRepo productRepo;

  GetProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, ProductEntity>> call(String productId) async {
    return await productRepo.getProduct(
      productId: productId,
    );
  }
}
