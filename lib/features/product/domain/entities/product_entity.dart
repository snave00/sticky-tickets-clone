import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/remote_models/product_model.dart';
import 'product_customization_entity.dart';

part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

@freezed
class ProductEntity with _$ProductEntity {
  ProductEntity._();

  factory ProductEntity({
    required final String productId,
    required final String productCategoryId,
    required final String productName,
    required final String productDesc,
    required final String productPrice,
    required final String productImage,
    required final bool isAvailable,
    required final bool isFavorite,
    required final bool isPopular,
    required final String rating,
    required final List<ProductCustomizationEntity> customizations,
  }) = _ProductEntity;

  factory ProductEntity.empty() {
    return ProductEntity(
      productId: '',
      productCategoryId: '',
      productName: '',
      productDesc: '',
      productPrice: '',
      productImage: '',
      isAvailable: false,
      isFavorite: false,
      isPopular: false,
      rating: '',
      customizations: [],
    );
  }

  ProductModel toRemoteModel() => ProductModel(
        productId: productId,
        productCategoryId: productCategoryId,
        productName: productName,
        productDesc: productDesc,
        productPrice: productPrice,
        productImage: productImage,
        isAvailable: isAvailable,
        isFavorite: isFavorite,
        isPopular: isPopular,
        rating: rating,
        customizations: customizations
            .map(
              (e) => e.toRemoteModel(),
            )
            .toList(),
      );

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);
}
