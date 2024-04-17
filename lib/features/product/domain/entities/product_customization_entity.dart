import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/remote_models/product_customization_model.dart';

part 'product_customization_entity.freezed.dart';
part 'product_customization_entity.g.dart';

@freezed
class ProductCustomizationEntity with _$ProductCustomizationEntity {
  ProductCustomizationEntity._();

  factory ProductCustomizationEntity({
    required final String option,
    required final List<String> choices,
  }) = _ProductCustomizationEntity;

  factory ProductCustomizationEntity.empty() {
    return ProductCustomizationEntity(
      option: '',
      choices: [],
    );
  }

  ProductCustomizationModel toRemoteModel() => ProductCustomizationModel(
        option: option,
        choices: choices,
      );

  factory ProductCustomizationEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationEntityFromJson(json);
}
