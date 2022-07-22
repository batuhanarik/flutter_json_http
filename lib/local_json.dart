import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  @override
  Widget build(BuildContext context) {
    readCarsJson();
    return Scaffold(
      appBar:AppBar(
        title:const Text('Local Json Operations'),
      ),
      body:const Center(),
    );
  }



  readCarsJson() async {
    String readingString = await DefaultAssetBundle.of(context).loadString('assets/data/cars.json');

    var myJsonObject = jsonDecode(readingString);
    debugPrint("*********");
    // (myJsonObject as List).map((e)=>debugPrint(e.toString()));
    // debugPrint(myJsonObject.toString());

    List carList = myJsonObject;
    debugPrint(carList[0]['model'][0]['price'].toString());
  }
}