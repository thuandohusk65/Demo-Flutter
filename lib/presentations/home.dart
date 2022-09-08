import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/UserInfo.dart';
import 'package:flutter_project/grobotmarket/view/GrobotMarket.dart';
import 'package:flutter_project/presentations/google_map.dart';
import 'package:flutter_project/utils/utils.dart';
import 'mutiple_img_to_pdf.dart';

class HomeScreen extends StatefulWidget {
  final tabSize = 2;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  var titleBar = "";

  void getTitleBar() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = 'Bearer ${UserUtils.accessToken}';
      final response =
          await dio.get('http://api.beta.radiantgalaxy.io/sdk/v1/user/info');
      Map<String, dynamic> dataResponse = json.decode(response.toString());
      final userInfo = UserInfo.fromJson(dataResponse);
      print("user info" + userInfo.userName);
      setState(() {
        titleBar = 'Hello ' + userInfo.userName;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTitleBar();
    _tabController = TabController(length: widget.tabSize, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Widget'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[Text('Grobot market'), Text('Convert Pdf')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          GrobotMaket(),
          MutipleImageToPdf()
        ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) => MapSample()));
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.map),
        )
    );
  }
}
