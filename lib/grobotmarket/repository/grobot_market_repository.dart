import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_project/grobotmarket/service/grobot_market_service.dart';
import 'package:flutter_project/login/service/login_service.dart';
import 'package:flutter_project/models/Grobot.dart';
import 'package:flutter_project/models/UserToken.dart';
import 'package:flutter_project/utils/utils.dart';

class GrobotMarketRepository {

  Future<List<Data>?> getGrobotMarket() async {
    try {
      final grobotMarketService = GrobotMarketService();
      var response = await grobotMarketService.getGrobotMarket();
      Map<String, dynamic> dataResponse = json.decode(response.toString());
      final listGrobotResponse = ListGrobot.fromJson(dataResponse);
      return listGrobotResponse.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}