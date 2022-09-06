class UserToken {
  String accessToken = "";
  String refreshToken = "";

  UserToken(this.accessToken, this.refreshToken);

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
