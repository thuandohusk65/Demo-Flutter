import 'package:flutter/material.dart';
import '../googlemap/google_map.dart';
import '../grobotmarket/view/grobot_market.dart';
import '../scanpdf/view/multiple_img_to_pdf.dart';

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
          automaticallyImplyLeading: false,
          title: const Text('Grobot Market'),
          actions: [
            IconButton(
                icon: const Icon(Icons.map),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MapSample()));
                }),
            IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutipleImageToPdf()));
                })
          ],
        ),
        body: const GrobotMaket());
  }
}
