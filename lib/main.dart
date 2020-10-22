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
  List<Data> listFilter = [];

  Widget _widgetSearchView() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(
                Icons.search,
                color: Colors.yellow[600],
              ),
              onTap: () {},
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: TextField(
              onChanged: (text) {
                SearchMethod(text);
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Buscar..."),
            ))
          ],
        ),
      ),
    );
  }

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
            values[key]['userId'],
            key);
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
          body: SafeArea(
              child: Column(
            children: <Widget>[
              _widgetSearchView(),
              Container(
                child: Expanded(
                  child: list.length == 0
                      ? Center(
                          child: Text(
                          "No hay datos disponibles",
                          style: TextStyle(fontSize: 30),
                        ))
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDataFunction(
                                    context,
                                    list[index].answer,
                                    list[index].guideId,
                                    list[index].questionId,
                                    list[index].right,
                                    list[index].studentEventId,
                                    list[index].time,
                                    list[index].timestamp,
                                    list[index].userId);
                              },
                              child: CardUI(
                                  context,
                                  list[index].answer,
                                  list[index].guideId,
                                  list[index].questionId,
                                  list[index].right,
                                  list[index].studentEventId,
                                  list[index].time,
                                  list[index].timestamp,
                                  list[index].userId),
                            );
                          }),
                ),
              )
            ],
          ))),
    );
  }

  void SearchMethod(String text) {
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
            values[key]['userId'],
            key);
        if (data.userId.contains(text)) {
          list.add(data);
        }
      }
      setState(() {});
    });
  }

  Widget CardUI(
      BuildContext context,
      String answer,
      String guideId,
      int questonId,
      bool right,
      String studentEventId,
      int time,
      int timestamp,
      String userId) {
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

  showDataFunction(
      BuildContext context,
      String answer,
      String guideId,
      int questonId,
      bool right,
      String studentEventId,
      int time,
      int timestamp,
      String userId) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 320,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "UserId" + '\n' + userId,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "StudentEventId" + '\n' + studentEventId,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "GuideId" + '\n' + guideId,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "Answer" + '\n' + answer,
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "QuestionId" + '\n' + questonId.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "Right" + '\n' + right.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "timestamp" +
                            '\n' +
                            DateTime.fromMicrosecondsSinceEpoch(timestamp)
                                .toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "time" +
                            '\n' +
                            DateTime.fromMicrosecondsSinceEpoch(time)
                                .toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
