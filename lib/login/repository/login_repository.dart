import 'dart:convert';
import 'package:flutter_project/login/service/login_service.dart';
import 'package:flutter_project/models/UserToken.dart';
import 'package:flutter_project/utils/utils.dart';

class LoginRepository {
  Future<UserToken> getUserInfor() async {
    final loginService = LoginService();
    var response = await loginService.getUserToken();
    try {
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
}