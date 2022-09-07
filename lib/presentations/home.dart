
import 'package:flutter/material.dart';
import 'package:flutter_project/grobotmarket/view/GrobotMarket.dart';
import 'package:flutter_project/presentations/google_map.dart';
import 'multiple_img_to_pdf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Widget'),
        actions: [
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) => MapSample()));
              }),
          IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) => MutipleImageToPdf()));
              })
        ],
      ),
      body:
          const GrobotMaket()
    );
  }
}
