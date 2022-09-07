import 'package:dio/dio.dart';

class LoginService {
  Future<Response<dynamic>> getUserToken() async {
    var response = await Dio().post(
        'http://api.beta.radiantgalaxy.io/sdk/v1/auth/login/credential',
        data: {
          'email': 'chhh@gmail.com',
          'password': '123qweA@'
        });
    return response;
  }
}