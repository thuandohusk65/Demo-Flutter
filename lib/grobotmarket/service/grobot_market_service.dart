import 'dart:convert';

import 'package:dio/dio.dart';

class GrobotMarketService {

  Future<Response<dynamic>> getGrobotMarket() async {
    try {
      Response<dynamic> response = await Dio().get(
          'https://api.beta.radiantgalaxy.io/v1/market/grobot/selling?page=0&size=20&sortType=ASC&sortBy=PRICE&minStar=1&maxStar=9&minDurability=0&maxDurability=100&quality=1,2,3,4&gene=1,2,3,4,5&gclass=1,2,3,4,5,6');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
