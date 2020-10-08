import 'package:flutter/material.dart';
import 'package:hsc/login/login.dart';
import 'package:hsc/question/qna.dart';
import 'package:hsc/utils/colors.dart';
import 'package:hsc/widgets/hsc_appbar.dart';
import 'package:mysql1/mysql1.dart';

import 'choose_language.dart';

class MenuPage extends StatelessWidget {
  // TODO: Make a collection of cards (102)

  MenuPage();
  //list.add(false);
  Drawer _getDrawer(BuildContext context) {
    return Drawer(
        child: Container(
      color: mainColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pages',
                  style: TextStyle(
                      fontFamily: 'SCDream',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: mainColor),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: backGroundColor,
            ),
            title: Text('문의하기 ',
                style: TextStyle(
                    fontFamily: 'SCDream',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: backGroundColor)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QnAPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: backGroundColor,
            ),
            title: Text('Logout',
                style: TextStyle(
                    fontFamily: 'SCDream',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: backGroundColor)),
            onTap: () async {
              await _logout(context);
            },
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            // TODO: Add app bar (102)
            drawer: _getDrawer(context),
            appBar: HscAppBar(
                title: new Center(
                    child: new Text("필요한 정보를 선택해 주세요",
                        style: TextStyle(
                          fontFamily: 'SCDream',
                        ))),
                actions: <Widget>[]),

            // TODO: Add a grid view (102)

            // TODO: Set resizeToAvoidBottomInset (101)*/
            body: Column(
              children: <Widget>[
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        await _goToLanguage("camp", context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(width: 5, color: mainColor))),
                        alignment: Alignment.center,
                        child: Text(
                          "💻 캠프 💻  ",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    )),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      await _goToLanguage("club", context);
                    },
//
                    child: Container(
                      margin: EdgeInsets.all(0.1),
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 5, color: mainColor))),
                      alignment: Alignment.center,
                      child: Text(
                        "👥 동아리 👥 ",
                        style: TextStyle(
                            fontFamily: 'SCDream',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      await _goToLanguage("lab", context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(0.1),
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 5, color: mainColor))),
                      alignment: Alignment.center,
                      child: Text(
                        "👨🏻‍💻 랩실 👩🏻‍💻",
                        style: TextStyle(
                            fontFamily: 'SCDream',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        await _goToLanguage("academy", context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(width: 5, color: mainColor))),
                        alignment: Alignment.center,
                        child: Text(
                          "📊 학회 📂",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    )),
//
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        await _goToLanguage("employment", context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(width: 5, color: mainColor))),
                        alignment: Alignment.center,
                        child: Text(
                          "🏢 취업정보 🏢",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    )),
              ],
            )
//            ListView(
//              children: <Widget>[
//                ListTile(
//                  title: Text("수업정보"),
//                ),
//                ListTile(
//                  title: Text("동아리&학회"),
//                ),
//                ListTile(
//                  title: Text("켐프"),
//                ),
//                ListTile(
//                  title: Text("취업정보"),
//                ),
//                ListTile(
//                  title: Text("현장 실습 정보"),
//                ),
//              ],
//            )
            ));
  }

  Future _goToLanguage(String category, BuildContext context) async {
    var lanInfo = [];
    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');

    var conn = await MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

    var result = await conn.query(
        'select distinct language.language_id from language,${category}_language WHERE language.language_id=${category}_language.language_id order by language.language_id');
//                  result.
//    print("${result.toString()}");
    for (var row in result) {
      lanInfo.add(row[0]);
    }

    await conn.close();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LanguagePage(category, lanInfo),
        ));
  }

  Future<void> _logout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "로그아웃 하시겠습니까?",
              style: TextStyle(
                  fontFamily: 'SCDream',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            actions: <Widget>[
              OutlineButton(
                child: Text(
                  "아니요",
                  style: TextStyle(
                      fontFamily: 'SCDream',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                borderSide: BorderSide(style: BorderStyle.none),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              OutlineButton(
                child: Text(
                  "네",
                  style: TextStyle(
                      fontFamily: 'SCDream',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                borderSide: BorderSide(style: BorderStyle.none),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          );
        });
  }
}
