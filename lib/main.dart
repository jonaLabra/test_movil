import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var json;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  void start() {
    DatabaseReference referenceData = FirebaseDatabase.instance.reference();

    referenceData.once().then((DataSnapshot dataSnapShot) {
      setState(() {
        var values = dataSnapShot.value;
        print(values);
        json = dataSnapShot.value;
        var widget = JsonWidgetData.fromDynamic(json);
        data = widget.build(context: context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Datos Firebase'),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  start();
                })
          ],
        ),
        body: json != null
            ? data
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
