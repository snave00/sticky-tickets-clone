import '../../../features/product/domain/entities/product_category_entity.dart';
import '../../constants/asset_const.dart';
import '../../enums/product_category_enum.dart';

List<ProductCategoryEntity> addAllCategory({
  required List<ProductCategoryEntity> productCategories,
}) {
  // create copy
  var copyProducts = [...productCategories];

  // insert at start
  copyProducts.insert(
    0,
    ProductCategoryEntity(
      productCategoryId: ProductCategoryEnum.all.productCategoryId,
      productCategoryName: ProductCategoryEnum.all.title,
      productCategoryDesc: '',
      image: AssetConst.icAll,
    ),
  );

  return copyProducts;
}
