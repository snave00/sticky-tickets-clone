import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_customization_entity.dart';

part 'product_customization_model.freezed.dart';
part 'product_customization_model.g.dart';

@freezed
class ProductCustomizationModel with _$ProductCustomizationModel {
  ProductCustomizationModel._();

  factory ProductCustomizationModel({
    final String? option,
    final List<String>? choices,
  }) = _ProductCustomizationModel;

  factory ProductCustomizationModel.empty() {
    return ProductCustomizationModel(
      option: '',
      choices: [],
    );
  }

  factory ProductCustomizationModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationModelFromJson(json);

  ProductCustomizationEntity toEntity() => ProductCustomizationEntity(
        option: option ?? '',
        choices: choices ?? [],
      );
}
