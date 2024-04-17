part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required HomeProductCategoriesStatus homeProductCategoriesStatus,
    required HomeProductsStatus homeProductsStatus,
    required HomePromosStatus homePromosStatus,
    required List<ProductCategoryEntity> productCategories,
    required List<ProductEntity> products,
    required List<PromoEntity> promos,
    required String selectedProductCategoryId,
    final String? successMessage,
    final String? errorMessage,
  }) = _HomeState;
}

enum HomeProductCategoriesStatus {
  initial,
  getProductCategoriesLoading,
  getProductCategoriesSuccess,
  failure,
}

enum HomeProductsStatus {
  initial,
  getProductsLoading,
  getProductsSuccess,
  failure,
}

enum HomePromosStatus {
  initial,
  getPromosLoading,
  getPromosSuccess,
  failure,
}
