class UserInfo {
  int id = 0;
  String avatarUrl = "";
  String userName = "";
  String email = "";
  String walletAddress = "";

  UserInfo(this.id, this.avatarUrl, this.userName, this.email,
      this.walletAddress);

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarUrl = json['avatarUrl'];
    userName = json['userName'];
    email = json['email'];
    walletAddress = json['walletAddress'];
  }
}

/*
 {
    "id": 1,
    "avatarUrl": "https://radiantgalaxy.sgp1.digitaloceanspaces.com/dev/avatar/Account_Panel_AvartarDefaul.png",
    "userName": "ALOALO1",
    "email": "chhh@gmail.com",
    "walletAddress": "0x481c0e7b2f0b8b0936f5f962fd19453089d547e0"
}*/