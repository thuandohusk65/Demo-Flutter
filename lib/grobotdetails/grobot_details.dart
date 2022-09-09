import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/grobotdetails/widget/grobot_details_page.dart';

import '../models/Grobot.dart';

class GrobotDetail extends StatelessWidget {
  final Gmodel gmodel;
  final int tag;

  GrobotDetail(this.gmodel, this.tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(gmodel.name!),
      ),
      body: GrobotDetailPage(gmodel, tag)
    );
  }
}
