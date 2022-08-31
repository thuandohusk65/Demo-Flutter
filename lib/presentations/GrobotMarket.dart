import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/component/GrobotItem.dart';
import 'package:flutter_project/model/Grobot.dart';
import 'package:flutter_project/model/MyGrobots.dart';
import 'package:flutter_project/model/UserInfo.dart';
import 'package:flutter_project/utils/utils.dart';

class GrobotMaket extends StatefulWidget {
  bool isMarket = true;

  GrobotMaket(this.isMarket, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GrobotMarketState(isMarket);
}

class _GrobotMarketState extends State<GrobotMaket> {
  List<Data>? listGrobot;
  List<Robots>? robots;
  bool isMarket;

  _GrobotMarketState(this.isMarket);

  void getGrobotList() async {
    try {
      final Response<dynamic> response;
      if (isMarket) {
        response = await Dio().get(
            'https://api.beta.radiantgalaxy.io/v1/market/grobot/selling?page=0&size=20&sortType=ASC&sortBy=PRICE&minStar=1&maxStar=9&minDurability=0&maxDurability=100&quality=1,2,3,4&gene=1,2,3,4,5&gclass=1,2,3,4,5,6');
        Map<String, dynamic> dataResponse = json.decode(response.toString());
        final listGrobotResponse = ListGrobot.fromJson(dataResponse);
        setState(() {
          listGrobot = listGrobotResponse.data;
        });
      } else {
        Dio dio = Dio();
        dio.options.headers["Authorization"] = 'Bearer ${UserUtils.accessToken}';
        response = await dio.get(
            'https://api.beta.radiantgalaxy.io/v1/gatewar/grobot/game');
        Map<String, dynamic> dataResponse = json.decode(response.toString());
        final listGrobotResponse = MyGrobots.fromJson(dataResponse);
        setState(() {
          robots = listGrobotResponse.robots!;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getGrobotList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ((isMarket && listGrobot != null &&
                listGrobot!.isNotEmpty) || (!isMarket && robots!.isNotEmpty))
                ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: (isMarket) ? List.generate(
                  listGrobot!.length, (index) =>
              listGrobot![index].grobot != null ?
              GroBotItem(listGrobot![index].grobot!.gmodel!.cardUrl!,
                  listGrobot![index].grobot!.gmodel!.name!) : const SizedBox()
              ) : List.generate(robots!.length, (index) =>
              robots![index] != null
                  ?
              GroBotItem(
                  robots![index].gmodel!.cardUrl!, robots![index].gmodel!.name!)
                  : const SizedBox()),
            )
                : const Center(child: CircularProgressIndicator()))

    );
  }
}
