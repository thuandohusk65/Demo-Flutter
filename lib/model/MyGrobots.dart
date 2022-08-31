import 'Grobot.dart';

class MyGrobots {
  List<Robots>? robots;
  int? total;

  MyGrobots({this.robots, this.total});

  MyGrobots.fromJson(Map<String, dynamic> json) {
    if(json["robots"] is List)
      this.robots = json["robots"]==null ? null : (json["robots"] as List).map((e)=>Robots.fromJson(e)).toList();
    if(json["total"] is int)
      this.total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.robots != null)
      data["robots"] = this.robots?.map((e)=>e.toJson()).toList();
    data["total"] = this.total;
    return data;
  }
}

class Robots {
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

  Robots({this.id, this.atrophyPoint, this.originAtrophyPoint, this.idNft, this.star, this.status, this.ggenre, this.gmodel, this.gquality, this.gclass});

  Robots.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int)
      this.id = json["id"];
    if(json["atrophyPoint"] is int)
      this.atrophyPoint = json["atrophyPoint"];
    if(json["originAtrophyPoint"] is int)
      this.originAtrophyPoint = json["originAtrophyPoint"];
    if(json["idNFT"] is int)
      this.idNft = json["idNFT"];
    if(json["star"] is int)
      this.star = json["star"];
    if(json["status"] is String)
      this.status = json["status"];
    if(json["ggenre"] is int)
      this.ggenre = json["ggenre"];
    if(json["gmodel"] is Map)
      this.gmodel = json["gmodel"] == null ? null : Gmodel.fromJson(json["gmodel"]);
    if(json["gquality"] is int)
      this.gquality = json["gquality"];
    if(json["gclass"] is int)
      this.gclass = json["gclass"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}