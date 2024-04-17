import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../../../utils/constants/asset_const.dart';
import '../models/remote_models/promo_model.dart';

abstract class PromoMockDataSource {
  Future<List<PromoModel>> getPromos();
}

class PromoMockDataSourceImpl implements PromoMockDataSource {
  @override
  Future<List<PromoModel>> getPromos() async {
    final String response = await rootBundle.loadString(
      AssetConst.promoMockData,
    );

    // get promos
    final promos = await Isolate.run(
      () => getPromosMockData(response),
    );

    return promos;
  }
}

// made it top level function so it can be isolated
Future<List<PromoModel>> getPromosMockData(String response) async {
  final List<dynamic> parsed = jsonDecode(response);
  return parsed.map((promoJson) => PromoModel.fromJson(promoJson)).toList();
}
