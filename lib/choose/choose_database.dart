import 'package:flutter/material.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';
import 'package:mysql1/mysql1.dart';

import 'choose_framework.dart';

class DatabasePage extends StatelessWidget {
  final String category;
  final String selectedLan;
  final List dbInfo;

  DatabasePage(
    this.category,
    this.selectedLan,
    this.dbInfo,
  );

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
                  "데이타베이스를 선택해 주세요.",
                  style: TextStyle(fontFamily: 'SCDream', fontSize: 20),
                ),
              )),

          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                if (index == 0) {
                  return GestureDetector(
                      onTap: () async {
                        await _goToFramwork(
                            selectedLan, "no", category, context);
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
                } else
                  return GestureDetector(
                      onTap: () async {
                        await _goToFramwork(
                            selectedLan, dbInfo[index - 1], category, context);
                      },
                      child: Card(
                          child: ListTile(
                              title: Center(
                        heightFactor: 4,
                        child: Text(
                          dbInfo[index - 1],
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))));
              },
              itemCount: dbInfo.length + 1,
            ),
          ),
//
//
//          _getLanguage()
        ],
      ),
    );
  }

  Future _goToFramwork(String selectedLan, String selectedDb, String category,
      BuildContext context) async {
    var frameInfo = [];
    var frameId = [];

    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');

    var conn = await MySqlConnection.connect(settings);

    var result = await conn.query(
        'select distinct framework.framework_id from framework,${category}_framework WHERE framework.framework_id=${category}_framework.framework_id order by framework.framework_id');
//                  result.
//    print("${result.toString()}");
    for (var row in result) {
      frameInfo.add(row[0]);
    }

    await conn.close();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FramworkPage(category, selectedLan, selectedDb, frameInfo),
        ));
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
