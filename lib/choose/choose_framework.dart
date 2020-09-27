import 'package:flutter/material.dart';
import 'package:hsc/choose/result.dart';
import 'package:hsc/choose/result_employment.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';
import 'package:mysql1/mysql1.dart';

class FramworkPage extends StatelessWidget {
  final String category;
  final String selectedLan;
  final String selectedDb;
  final List frameworkInfo;

  FramworkPage(
      this.category, this.selectedLan, this.selectedDb, this.frameworkInfo);

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
                  "프레임워크를 선택해 주세요.",
                  style: TextStyle(fontFamily: 'SCDream', fontSize: 20),
                ),
              )),

          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                if (index == 0) {
                  return GestureDetector(
                      onTap: () async {
                        await _goToResultPage(
                            selectedLan, selectedDb, "no", category, context);
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
                        await _goToResultPage(selectedLan, selectedDb,
                            frameworkInfo[index - 1], category, context);
                      },
                      child: Card(
                          child: ListTile(
                              title: Center(
                        heightFactor: 4,
                        child: Text(
                          frameworkInfo[index - 1],
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))));
//                return GestureDetector(
//                    onTap: () async {
//                      await _goToFramwork(
//                          selectedLan,
//                          selectedLanId,
//                          dbInfo[index - 1],
//                          dbId[index - 1],
//                          category,
//                          context);
//                    },
//                    child: Container(
//                        height: 100,
//                        child: Center(
//                          child: Text(
//                            dbInfo[index - 1],
//                            style: TextStyle(fontSize: 20),
//                          ),
//                        )));
              },
              itemCount: frameworkInfo.length + 1,
            ),
          ),
//
//
//          _getLanguage()
        ],
      ),
    );
  }

  Future _goToResultPage(String selectedLan, String selectedDb,
      String selectedFrame, String category, BuildContext context) async {
    if (category == "employment") {
      var name = [];
      var duration = [];
      var prefer = [];
      var qualification = [];

      var company = [];
      var count = [];
      var list = [selectedLan, selectedDb, selectedFrame];

//      int lanId = int.parse(selectedLanId);
//      int dbId = int.parse(selectedDbId);
//      int frameId = int.parse(selectedFrameId);

      var settings = new ConnectionSettings(
          host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
          port: 3306,
          user: 'db_hcs',
          password: '20202020',
          db: 'hcs');
      var conn = await MySqlConnection.connect(settings);

      Results lanResult = await conn.query(
          "select name,duration,prefer_treatment,qualification,company_id from $category,(select ${category}_id from ${category}_language WHERE language_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedLan]);
//    print("${lanResult.toString()}");
      int i = 0;
      for (var row in lanResult) {
        name.add(row[0]);
        duration.add(row[1]);
        prefer.add(row[2]);
        qualification.add(row[3]);
        company.add(row[4]);

        i++;
      }
      count.add(i);

      Results dbResult = await conn.query(
          "select name,duration,prefer_treatment,qualification,company_id from $category,(select ${category}_id from ${category}_database WHERE database_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedDb]);
      print(dbResult.toString());
      for (var row in dbResult) {
        name.add(row[0]);
        duration.add(row[1]);
        prefer.add(row[2]);
        qualification.add(row[3]);
        company.add(row[4]);
        i++;
      }

      count.add(i);

      Results frameResult = await conn.query(
          "select name,duration,prefer_treatment,qualification,company_id  from $category,(select ${category}_id from ${category}_framework WHERE framework_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedFrame]);
//    print(frameResult.toString());
      for (var row in frameResult) {
        name.add(row[0]);
        duration.add(row[1]);
        prefer.add(row[2]);
        qualification.add(row[3]);
        company.add(row[4]);
        i++;
      }

      count.add(i);
      await conn.close();

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultEmploymentPage(category, list, count,
                name, duration, prefer, qualification, company),
          ));
    } else {
      var intro = [];
      var name = [];
      var prof = [];
      var count = [];
      var list = [selectedLan, selectedDb, selectedFrame];

//      int lanId = int.parse(selectedLanId);
//      int dbId = int.parse(selectedDbId);
//      int frameId = int.parse(selectedFrameId);

      var settings = new ConnectionSettings(
          host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
          port: 3306,
          user: 'db_hcs',
          password: '20202020',
          db: 'hcs');
      var conn = await MySqlConnection.connect(settings);

//      select introduction,name,professor from academy JOIN academy_language ON academy.academy_id= academy_language.academy_id AND academy_language.language_id='c';
      Results lanResult = await conn.query(
          "select introduction,name,professor from $category,(select ${category}_id from ${category}_language WHERE language_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedLan]);

//    print("${lanResult.toString()}");
      int i = 0;
      for (var row in lanResult) {
        intro.add(row[0]);
        name.add(row[1]);
        prof.add(row[2]);
        print(row[1]);
        i++;
      }
      count.add(i);

      Results dbResult = await conn.query(
          "select introduction,name,professor from $category,(select ${category}_id from ${category}_database WHERE database_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedDb]);

      print(dbResult.toString());
      for (var row in dbResult) {
        intro.add(row[0]);
        name.add(row[1]);
        prof.add(row[2]);
        print(row[1]);
        i++;
      }

      count.add(i);

      Results frameResult = await conn.query(
          "select introduction,name,professor from $category,(select ${category}_id from ${category}_framework WHERE framework_id=?) as quary WHERE $category.${category}_id=quary.${category}_id",
          [selectedFrame]);

//    print(frameResult.toString());
      for (var row in frameResult) {
        intro.add(row[0]);
        name.add(row[1]);
        prof.add(row[2]);
        print(row[1]);
        i++;
      }

      count.add(i);

      await conn.close();

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultPage(category, list, count, intro, name, prof),
          ));
    }
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
