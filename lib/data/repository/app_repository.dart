import 'dart:convert';
import 'package:flutter_project/data/service/app_service.dart';
import 'package:flutter_project/models/UserToken.dart';
import 'package:flutter_project/utils/utils.dart';
import '../../models/Grobot.dart';

class AppRepository {

  Future<UserToken> getUserToken(String acc, String pass) async {
    final appService = AppService();
    try {
      var response = await appService.getUserToken(acc, pass);
      Map<String, dynamic> dataResponse =
      json.decode(response.toString());
      final userToken = UserToken.fromJson(dataResponse);
      UserUtils.accessToken = userToken.accessToken;
      return userToken;
    } catch(e) {
      print(e);
      return UserToken("", "");
    }
  }

  Future<List<Data>?> getGrobotMarket() async {
    try {
      final appService = AppService();
      var response = await appService.getGrobotMarket();
      Map<String, dynamic> dataResponse = json.decode(response.toString());
      final listGrobotResponse = ListGrobot.fromJson(dataResponse);
      return listGrobotResponse.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}