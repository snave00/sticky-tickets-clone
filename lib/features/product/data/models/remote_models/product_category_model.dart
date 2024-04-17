import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_category_entity.dart';

part 'product_category_model.freezed.dart';
part 'product_category_model.g.dart';

@freezed
class ProductCategoryModel with _$ProductCategoryModel {
  ProductCategoryModel._();

  factory ProductCategoryModel({
    final String? productCategoryId,
    final String? productCategoryName,
    final String? productCategoryDesc,
    final String? image,
  }) = _ProductCategoryModel;

  factory ProductCategoryModel.empty() {
    return ProductCategoryModel(
      productCategoryId: '',
      productCategoryName: '',
      productCategoryDesc: '',
      image: '',
    );
  }

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryModelFromJson(json);

  ProductCategoryEntity toEntity() => ProductCategoryEntity(
        productCategoryId: productCategoryId ?? '',
        productCategoryName: productCategoryName ?? '',
        productCategoryDesc: productCategoryDesc ?? '',
        image: image ?? '',
      );
}
