import 'package:flutter/material.dart';
import 'package:hsc/choose/choose_menu.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';

class ResultPage extends StatelessWidget {
  final String category;
  final List list;
  final List idx;
  final List intro;
  final List name;
  final List prof;

  ResultPage(
      this.category, this.list, this.idx, this.intro, this.name, this.prof);

  @override
  Widget build(BuildContext context) {
    print(
        idx[0].toString() + "," + idx[1].toString() + "," + idx[2].toString());
    return Scaffold(
      appBar: HscAppBarBack(
        context: context,
        title: Text("$category",
            style: TextStyle(
              fontFamily: 'SCDream',
              fontWeight: FontWeight.bold,
            )),
        leading: new Icon(Icons.keyboard_backspace),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index < idx[0])
                  return GestureDetector(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.indigo[50],
                          child: ListTile(
                            leading: Text(list[0]),
                            title: Text("⚡️" + " " + name[index],
                                style: TextStyle(
                                    fontFamily: 'SCDream',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19)),
                            subtitle: Text(
                              "\n" +
                                  intro[index] +
                                  "\n" +
                                  "\n" +
                                  prof[index] +
                                  " 교수님",
                              style: TextStyle(
                                  fontFamily: 'SCDream',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )));
                else if (index < idx[1])
                  return GestureDetector(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.indigo[50],
                          child: ListTile(
                            leading: Text(list[1]),
                            title: Text("⚡️" + " " + name[index],
                                style: TextStyle(
                                    fontFamily: 'SCDream',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            subtitle: Text(
                              "\n" +
                                  intro[index] +
                                  "\n" +
                                  "\n" +
                                  prof[index] +
                                  " 교수님",
                              style: TextStyle(
                                  fontFamily: 'SCDream',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )));
                else
                  return GestureDetector(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.indigo[50],
                          child: ListTile(
                            leading: Text(list[1]),
                            title: Text("⚡️" + " " + name[index],
                                style: TextStyle(
                                    fontFamily: 'SCDream',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            subtitle: Text(
                              "\n" +
                                  intro[index] +
                                  "\n" +
                                  "\n" +
                                  prof[index].toString() +
                                  " 교수님",
                              style: TextStyle(
                                  fontFamily: 'SCDream',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )));
              },
              itemCount: intro.length,
            ),
          ),
//
//
//          _getLanguage()
        ],
      ),
    );
  }
}
