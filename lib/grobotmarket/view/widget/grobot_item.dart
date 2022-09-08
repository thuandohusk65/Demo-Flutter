import 'package:flutter/material.dart';
import 'package:flutter_project/grobotdetails/grobot_details.dart';

import '../../../models/Grobot.dart';

class GroBotItem extends StatelessWidget {
  final Gmodel gmodel;

  GroBotItem(this.gmodel, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GrobotDetail(gmodel)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12) //<-- SEE HERE
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: Image.network(
                      // <-- SEE HERE
                      gmodel.cardUrl!,
                      fit: BoxFit.fitHeight)),
              Text(gmodel.name!,
                  style:
                      const TextStyle(color: Colors.deepOrange, fontSize: 16)
              )
            ],
          ),
        ));
  }
}
