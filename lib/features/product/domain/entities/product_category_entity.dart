import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/remote_models/product_category_model.dart';

part 'product_category_entity.freezed.dart';
part 'product_category_entity.g.dart';

@freezed
class ProductCategoryEntity with _$ProductCategoryEntity {
  ProductCategoryEntity._();

  factory ProductCategoryEntity({
    required final String productCategoryId,
    required final String productCategoryName,
    required final String productCategoryDesc,
    required final String image,
  }) = _ProductCategoryEntity;

  factory ProductCategoryEntity.empty() {
    return ProductCategoryEntity(
      productCategoryId: '',
      productCategoryName: '',
      productCategoryDesc: '',
      image: '',
    );
  }

  ProductCategoryModel toRemoteModel() => ProductCategoryModel(
        productCategoryId: productCategoryId,
        productCategoryName: productCategoryName,
        productCategoryDesc: productCategoryDesc,
        image: image,
      );

  factory ProductCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryEntityFromJson(json);
}
