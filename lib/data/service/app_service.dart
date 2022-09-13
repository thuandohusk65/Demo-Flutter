import 'package:dio/dio.dart';

class AppService {
  Future<Response<dynamic>> getUserToken(String acc, String pass) async {
    try {
      var response = await Dio().post(
          'https://api.beta.radiantgalaxy.io/sdk/v1/auth/login/credential',
          data: {
            'email': acc,
            'password': pass
          });
      return response;
    }catch(e) {
      rethrow;
    }
  }

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