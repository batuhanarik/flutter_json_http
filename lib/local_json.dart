import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_http/model/car_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  String _title = 'Local Json Operations ';

  late final Future<List<Car>> _fillList;

  @override
  void initState() {
    super.initState();
    _fillList = readCarsJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        setState(() {
          _title = 'Buton was clicked.';
        });
      }),
      body: FutureBuilder<List<Car>>(
        future: _fillList,
        initialData: [Car(brandName: 'TOGG',country: 'Turkey',foundationYear: 2023,model: [
          Model(gasoline: true,modelName: 'TR30',price:22000),
        ])],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Car> carList = snapshot.data!;
            return ListView.builder(
                itemCount: carList.length,
                itemBuilder: (context, index) {
                  var currentCar = carList[index]; 
                  return ListTile(
                      title: Text(currentCar.brandName),
                      subtitle: Text(currentCar.country),
                      leading: CircleAvatar(
                        child: Text(currentCar.model[0].price.toString()),
                      ));
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Car>> readCarsJson() async {
    try {
      await Future.delayed(Duration(seconds:3),(){
        debugPrint('3sn lik işlem bitti');
      });
      String readingString = await DefaultAssetBundle.of(context)
          .loadString('assets/data/cars.json');
      var myJsonObject = jsonDecode(readingString);
      // (myJsonObject as List).map((e)=>debugPrint(e.toString()));
      // debugPrint(myJsonObject.toString());

      /*
    List carList = myJsonObject;
    debugPrint(carList[0]['model'][0]['price'].toString());
  */

      List<Car> allCars =
          (myJsonObject as List).map((carMap) => Car.fromMap(carMap)).toList();
      debugPrint(allCars.length.toString());

      return allCars;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
