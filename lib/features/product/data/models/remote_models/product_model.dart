import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';
import 'product_customization_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  ProductModel._();

  factory ProductModel({
    final String? productId,
    final String? productCategoryId,
    final String? productName,
    final String? productDesc,
    final String? productPrice,
    final String? productImage,
    final bool? isAvailable,
    final bool? isFavorite,
    final bool? isPopular,
    final String? rating,
    final List<ProductCustomizationModel>? customizations,
  }) = _ProductModel;

  factory ProductModel.empty() {
    return ProductModel(
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  ProductEntity toEntity() => ProductEntity(
        productId: productId ?? '',
        productCategoryId: productCategoryId ?? '',
        productName: productName ?? '',
        productDesc: productDesc ?? '',
        productPrice: productPrice ?? '',
        productImage: productImage ?? '',
        isAvailable: isAvailable ?? false,
        isFavorite: isFavorite ?? false,
        isPopular: isPopular ?? false,
        rating: rating ?? '',
        customizations: customizations
                ?.map(
                  (e) => e.toEntity(),
                )
                .toList() ??
            [],
      );
}
