import '../constants/string_const.dart';

enum ProductCategoryEnum {
  all(
    productCategoryId: 'all',
    title: StringConst.all,
  ),
  hotCoffee(
    productCategoryId: 'hot_coffee',
    title: StringConst.hotCoffee,
  ),
  icedCoffee(
    productCategoryId: 'iced_coffee',
    title: StringConst.icedCoffee,
  ),
  pasta(
    productCategoryId: 'pasta',
    title: StringConst.pasta,
  ),
  bread(
    productCategoryId: 'bread',
    title: StringConst.bread,
  );

  final String productCategoryId;
  final String title;

  const ProductCategoryEnum({
    required this.productCategoryId,
    required this.title,
  });
}
