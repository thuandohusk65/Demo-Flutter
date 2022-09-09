import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/Grobot.dart';

class GrobotDetailPage extends StatelessWidget{
  final Gmodel gmodel;
  final int tag;

  const GrobotDetailPage(this.gmodel, this.tag);

  @override
  Widget build(BuildContext context) {
    return bodyWidget(context);
  }
  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          left: 10.0,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    gmodel.name!,
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  gmodelProperties(
                      'Attack', gmodel.id!.toString(), Colors.red),
                  gmodelProperties(
                      'Hp', gmodel.hp!.toString(), Colors.lightGreen),
                  gmodelProperties('AttackSpeed',
                      gmodel.attackSpeed!.toString(), Colors.orange),
                  gmodelProperties('MoveSpeed',
                      gmodel.moveSpeed!.toString(), Colors.lightBlueAccent),
                  gmodelProperties(
                      'RadiusAttackRange',
                      gmodel.radiusAttackRange!.toString(),
                      Colors.deepPurpleAccent),
                  gmodelProperties(
                      'Status', gmodel.status!.toString(), Colors.yellow),
                ],
              ),
            ),
          )),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: "${tag}",
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(gmodel.cardUrl!))),
            )),
      )
    ],
  );

  Row gmodelProperties(String label, String value, Color? color) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 50,
              width: 100,
              child: Card(
                  semanticContainer: true,
                  margin: const EdgeInsets.all(10),
                  color: color ?? Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6) //<-- SEE HERE
                  ),
                  child: Center(
                      child: Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ))))
        ]);
  }
}