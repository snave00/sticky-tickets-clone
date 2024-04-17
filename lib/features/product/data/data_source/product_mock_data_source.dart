import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../../../utils/constants/asset_const.dart';
import '../../../../utils/enums/product_category_enum.dart';
import '../models/remote_models/product_category_model.dart';
import '../models/remote_models/product_model.dart';

abstract class ProductMockDataSource {
  Future<List<ProductModel>> getProducts({
    required String productCategoryId,
    required bool isPopular,
  });

  Future<ProductModel> getProduct({required String productId});

  Future<List<ProductCategoryModel>> getProductCategories();
}

class ProductMockDataSourceImpl implements ProductMockDataSource {
  @override
  Future<List<ProductModel>> getProducts({
    required String productCategoryId,
    required bool isPopular,
  }) async {
    final String response = await rootBundle.loadString(
      AssetConst.productMockData,
    );

    // get products
    final products = await Isolate.run(
      () => getProductsMockData(response),
    );

    // filter by categoryId. this mocks the query for your backend
    var productsFiltered = products.where(
      (element) {
        bool displayAllCategories =
            productCategoryId == ProductCategoryEnum.all.productCategoryId;
        bool matchCategoryId = element.productCategoryId == productCategoryId;
        bool matchPopularOnly = element.isPopular == true;

        // all and popular
        if (displayAllCategories && isPopular) {
          return matchPopularOnly;
        }

        // specific category and popular
        if (!displayAllCategories && isPopular) {
          return matchCategoryId && matchPopularOnly;
        }

        // specific category and no filter
        if (!displayAllCategories) {
          return matchCategoryId;
        }

        // all and no filter
        return true;
      },
    ).toList();

    return productsFiltered;
  }

  @override
  Future<ProductModel> getProduct({required String productId}) async {
    final String response = await rootBundle.loadString(
      AssetConst.productMockData,
    );

    // get products
    final products = await Isolate.run(
      () => getProductsMockData(response),
    );

    // filter by productId. this mocks the query for your backend
    final product = products.firstWhere(
      (element) => element.productId == productId,
    );

    return product;
  }

  @override
  Future<List<ProductCategoryModel>> getProductCategories() async {
    final String response = await rootBundle.loadString(
      AssetConst.productCategoryMockData,
    );

    // get product categories
    final productCategories = await Isolate.run(
      () => getProductCategoriesMockData(response),
    );

    return productCategories;
  }
}

// made it top level function so it can be isolated
Future<List<ProductModel>> getProductsMockData(String response) async {
  final List<dynamic> parsed = jsonDecode(response);
  return parsed.map((json) => ProductModel.fromJson(json)).toList();
}

// made it top level function so it can be isolated
Future<List<ProductCategoryModel>> getProductCategoriesMockData(
  String response,
) async {
  final List<dynamic> parsed = jsonDecode(response);
  return parsed.map((json) => ProductCategoryModel.fromJson(json)).toList();
}
