import 'package:flutter/material.dart';

class GroBotItem extends StatelessWidget {
  String urlImg;
  String name;

  GroBotItem(this.urlImg, this.name, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          height: 250,
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 200,
                  child: Image.network(
                      // <-- SEE HERE
                      urlImg,
                      fit: BoxFit.cover
                  )
              ),
              Text(name,
                  style:
                      const TextStyle(color: Colors.deepOrange, fontSize: 16))
            ],
          ),
        ));
  }
}
