import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/component/GrobotItem.dart';
import 'package:flutter_project/model/Grobot.dart';
import 'package:flutter_project/model/UserInfo.dart';
import 'package:flutter_project/utils/utils.dart';

class GrobotMaket extends StatefulWidget {
  const GrobotMaket({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GrobotMarketState();
}

class _GrobotMarketState extends State<GrobotMaket> {
  List<Data>? listGrobot;

  void getGrobotList() async {
    try {
      final response =
      await Dio().get(
          'https://api.beta.radiantgalaxy.io/v1/market/grobot/selling?page=0&size=20&sortType=ASC&sortBy=PRICE&minStar=1&maxStar=9&minDurability=0&maxDurability=100&quality=1,2,3,4&gene=1,2,3,4,5&gclass=1,2,3,4,5,6');
      Map<String, dynamic> dataResponse = json.decode(response.toString());
      final listGrobotResponse = ListGrobot.fromJson(dataResponse);
      setState(() {
        listGrobot = listGrobotResponse.data;
      });
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
            child: (listGrobot != null && listGrobot!.isNotEmpty) ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: List.generate(listGrobot!.length, (index) =>
              listGrobot![index].grobot != null?
              GroBotItem(listGrobot![index].grobot!): const SizedBox()
              ),
            ): const CircularProgressIndicator())

    );
  }
}
