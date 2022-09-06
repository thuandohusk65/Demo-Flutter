class ListGrobot {
  List<Data>? data;
  int? total;

  ListGrobot({this.data, this.total});

  ListGrobot.fromJson(Map<String, dynamic> json) {
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(this.data != null)
      data["data"] = this.data?.map((e)=>e.toJson()).toList();
    data["total"] = total;
    return data;
  }
}

class Data {
  int? id;
  String? owner;
  String? createdAt;
  double? price;
  Grobot? grobot;

  Data({this.id, this.owner, this.createdAt, this.price, this.grobot});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    owner = json["owner"];
    createdAt = json["createdAt"];
    price = json["price"];
    grobot = json["grobot"] == null ? null : Grobot.fromJson(json["grobot"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["owner"] = owner;
    data["createdAt"] = createdAt;
    data["price"] = price;
    if(grobot != null)
      data["grobot"] = grobot?.toJson();
    return data;
  }
}

class Grobot {
  int? id;
  double? atrophyPoint;
  double? originAtrophyPoint;
  int? idNft;
  int? star;
  String? status;
  int? ggenre;
  Gmodel? gmodel;
  int? gquality;
  int? gclass;

  Grobot({this.id, this.atrophyPoint, this.originAtrophyPoint, this.idNft, this.star, this.status, this.ggenre, this.gmodel, this.gquality, this.gclass});

  Grobot.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    atrophyPoint = json["atrophyPoint"];
    originAtrophyPoint = json["originAtrophyPoint"];
    idNft = json["idNFT"];
    star = json["star"];
    status = json["status"];
    ggenre = json["ggenre"];
    gmodel = json["gmodel"] == null ? null : Gmodel.fromJson(json["gmodel"]);
    gquality = json["gquality"];
    gclass = json["gclass"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["atrophyPoint"] = atrophyPoint;
    data["originAtrophyPoint"] = originAtrophyPoint;
    data["idNFT"] = idNft;
    data["star"] = star;
    data["status"] = status;
    data["ggenre"] = ggenre;
    if(gmodel != null)
      data["gmodel"] = gmodel?.toJson();
    data["gquality"] = gquality;
    data["gclass"] = gclass;
    return data;
  }
}

class Gmodel {
  int? id;
  int? status;
  String? url;
  String? cardUrl;
  String? name;
  double? attack;
  double? hp;
  int? moveSpeed;
  int? attackSpeed;
  int? radiusAttackRange;

  Gmodel({this.id, this.status, this.url, this.cardUrl, this.name, this.attack, this.hp, this.moveSpeed, this.attackSpeed, this.radiusAttackRange});

  Gmodel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    status = json["status"];
    url = json["url"];
    cardUrl = json["cardUrl"];
    name = json["name"];
    attack = json["attack"];
    hp = json["hp"];
    moveSpeed = json["moveSpeed"];
    attackSpeed = json["attackSpeed"];
    radiusAttackRange = json["radiusAttackRange"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["status"] = status;
    data["url"] = url;
    data["cardUrl"] = cardUrl;
    data["name"] = name;
    data["attack"] = attack;
    data["hp"] = hp;
    data["moveSpeed"] = moveSpeed;
    data["attackSpeed"] = attackSpeed;
    data["radiusAttackRange"] = radiusAttackRange;
    return data;
  }
}