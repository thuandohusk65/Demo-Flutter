import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/grobotdetails/grobot_details.dart';

import '../../../models/Grobot.dart';

class GroBotItem extends StatelessWidget {
  final Gmodel gmodel;
  final tag = Random().nextInt(1000);

  GroBotItem(this.gmodel, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GrobotDetail(gmodel, tag)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12) //<-- SEE HERE
              ),
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: Hero(
                      tag: "$tag",
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(gmodel.cardUrl!))),
                      ))),
              Text(gmodel.name!,
                  style:
                      const TextStyle(color: Colors.deepOrange, fontSize: 16))
            ],
          ),
        ));
  }
}
