import 'package:flutter/material.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';
import 'package:mysql1/mysql1.dart';

import 'choose_database.dart';

class LanguagePage extends StatelessWidget {
  final String category;
  final List lanInfo;

  LanguagePage(this.category, this.lanInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HscAppBarBack(
        context: context,
        title: Text(
          "한동 전전",
          style: TextStyle(
            fontFamily: 'SCDream',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 60,
              child: Center(
                child: Text(
                  "언어를 선택해 주세요.",
                  style: TextStyle(fontFamily: 'SCDream', fontSize: 20),
                ),
              )),

          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                if (index == 0)
                  return GestureDetector(
                      onTap: () async {
                        await _goToDatabase("no", category, context);
                      },
                      child: Card(
                        child: ListTile(
                            title: Container(
                                height: 80,
                                child: Center(
                                  child: Text(
                                    "선택안함",
                                    style: TextStyle(
                                        fontFamily: 'SCDream',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ))),
                      ));
                else
                  return GestureDetector(
                      onTap: () async {
                        await _goToDatabase(
                            lanInfo[index - 1], category, context);
                      },
                      child: Card(
                          child: ListTile(
                              title: Center(
                        heightFactor: 4,
                        child: Text(
                          lanInfo[index - 1],
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))));
              },
              itemCount: lanInfo.length + 1,
            ),
          ),

//          _getLanguage()
        ],
      ),
    );
  }

  Future _goToDatabase(
      String selectedLan, String category, BuildContext context) async {
    var dbInfo = [];
    var dbId = [];

    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');

    var conn = await MySqlConnection.connect(settings);

//                        String dbId =
//                            'select distinct language_id from camp_language order by language_id desc';

    var result = await conn.query(
        'select distinct db.database_id from db,${category}_database WHERE db.database_id=${category}_database.database_id order by db.database_id');
//                  result.
//    print("${result.toString()}");
    for (var row in result) {
      dbInfo.add(row[0]);
    }

    await conn.close();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DatabasePage(category, selectedLan, dbInfo),
        ));
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
