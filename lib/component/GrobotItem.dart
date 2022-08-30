import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/Grobot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroBotItem extends StatelessWidget {
  Grobot grobot;

  GroBotItem(this.grobot, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          // obtain shared preferences
          final prefs = await SharedPreferences.getInstance();
          // set value
          var a = prefs.getStringList('favGrobots');
          a!.add(grobot.id.toString());
          await prefs.setStringList('favGrobots', a);
          },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                  // <-- SEE HERE
                  grobot.gmodel!.cardUrl!,
                  fit: BoxFit.cover),
              Text(grobot.gmodel!.name!,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16))
            ],
          ),
        ));
  }
}
