import 'package:dio/dio.dart';

class LoginService {
  Future<Response<dynamic>> getUserToken(String acc, String pass) async {
    var response = await Dio().post(
        'http://api.beta.radiantgalaxy.io/sdk/v1/auth/login/credential',
        data: {
          'email': acc,
          'password': pass
        });
    return response;
  }
}