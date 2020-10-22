import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba_movil/model/Data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Data> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("answers");

    referenceData.once().then((DataSnapshot dataSnapShot) {
      list.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Data data = new Data(
            values[key]['answer'],
            values[key]['guideId'],
            values[key]['questionId'],
            values[key]['right'],
            values[key]['studentEventId'],
            values[key]['time'],
            values[key]['timestamp'],
            values[key]['userId']);
        list.add(data);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prueba Movil'),
        ),
        body: list.length == 0
            ? Center(
                child: Text(
                "No hay datos disponibles",
                style: TextStyle(fontSize: 30),
              ))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return CardUI(list[index].answer, list[index].userId);
                }),
      ),
    );
  }

  Widget CardUI(String answer, String userId) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(15),
      color: Colors.amberAccent,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              answer,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1,
            ),
            Text(userId,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.normal))
          ],
        ),
      ),
    );
  }
}
