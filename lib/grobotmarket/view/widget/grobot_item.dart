import 'package:flutter/material.dart';
import 'package:flutter_project/presentations/google_map.dart';

class GroBotItem extends StatelessWidget {
  String urlImg;
  String name;

  GroBotItem(this.urlImg, this.name, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // obtain shared preferences
          // final prefs = await SharedPreferences.getInstance();
          // // set value
          // var a = prefs.getStringList('favGrobots');
          // a!.add(grobot.id.toString());
          // await prefs.setStringList('favGrobots', a);
      Navigator.push(context,
          MaterialPageRoute(builder:
              (context) => MapSample()));
          },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                  // <-- SEE HERE
                  urlImg,
                  fit: BoxFit.cover),
              Text(name,
                  style: const TextStyle(color: Colors.deepOrange, fontSize: 16))
            ],
          ),
        ));
  }
}
