import 'package:flutter/material.dart';
import 'package:hsc/login/login_admin.dart';
import 'package:hsc/utils/colors.dart';
import 'package:mysql1/mysql1.dart' as C;

class AdminPage extends StatefulWidget {
//  const Bird({
//    Key key,
//    this.color = const Color(0xFFFFE306),
//    this.child,
//  }) : super(key: key);
//
//  final Color color;
//  final Widget child;
  const AdminPage(
      {Key key,
      this.category,
      this.where,
      this.name,
      this.introduction,
      this.prof,
      this.lan,
      this.db,
      this.framework})
      : super(key: key);

  final String category;
  final int where;
  final String name;
  final String introduction;
  final String prof;
  final List lan;
  final List db;
  final List framework;

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        title: Text(widget.name,
            style: TextStyle(
              fontFamily: 'SCDream',
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _logout();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.introduction,
              style: TextStyle(
                  fontFamily: 'SCDream',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
            height: 150,
            width: 400,
          ),

          SizedBox(
            height: 40,
          ),

          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Language ",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  height: 40,
                  width: 150,
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "추가",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select language_id from language WHERE language_id NOT IN (select language_id FROM ${widget.category}_language)');
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _addSomething("language", lan);
                      },
                    ),
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "삭제",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select language_id from language WHERE language_id IN (select language_id FROM ${widget.category}_language WHERE ${widget.category}_id=?)',
                            [widget.where]);
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _deleteSomething("language", lan);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Database ",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  height: 40,
                  width: 150,
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "추가",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select database_id from db WHERE database_id NOT IN (select database_id FROM ${widget.category}_database)');
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _addSomething("database", lan);
                      },
                    ),
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "삭제",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select database_id from db WHERE database_id IN (select database_id FROM ${widget.category}_database WHERE ${widget.category}_id=?)',
                            [widget.where]);
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _deleteSomething("database", lan);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Framework ",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  height: 40,
                  width: 150,
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "추가",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select framework_id from framework WHERE framework_id NOT IN (select framework_id FROM ${widget.category}_framework)');
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _addSomething("framework", lan);
                      },
                    ),
                    FlatButton(
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.teal[200],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "삭제",
                          style: TextStyle(
                              fontFamily: 'SCDream',
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        var lan = [];
                        var db = [];
                        var framework = [];

                        var settings = new C.ConnectionSettings(
                            host:
                                'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                            port: 3306,
                            user: 'db_hcs',
                            password: '20202020',
                            db: 'hcs');

                        var conn = await C.MySqlConnection.connect(settings);

//                        String lanId =
//                            'select distinct language_id from camp_language order by language_id desc';

                        var resultLan = await conn.query(
                            'select framework_id from framework WHERE framework_id IN (select framework_id FROM ${widget.category}_framework WHERE ${widget.category}_id=?)',
                            [widget.where]);
//                  result.

                        for (var row in resultLan) {
                          lan.add(row[0]);
                        }

                        await conn.close();

                        await _deleteSomething("framework", lan);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
//          _intro(widget.introduction),

//          forEach()

//          Column(
//            children: widget.lan.map<Widget>((v) => Text(v)).toList(),
//          ),
//          ListView.builder(
//              itemCount: widget.lan.length,
//              itemBuilder: (context, i) {
//                return Text(widget.lan[i]);
//              })

//          Text(widget.db[0]),
//          Text(widget.framework[0])
        ],
      ),
    );
  }

//  Future<String> _intro(String str) async{
//    await
//    return str;
  Future<void> _logout() {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginAdminPage()));
                },
              ),
            ],
          );
        });
  }

  Future<void> _addSomething(String type, List lan) {
    String setString;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "추가할 $type을 선택해주세요.",
                style: TextStyle(
                    fontFamily: 'SCDream',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: lan.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                              child: Text(
                                lan[i],
                                style: TextStyle(
                                    fontFamily: 'SCDream',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              onTap: () async {
                                setState(() {
                                  setString = lan[i];
                                });

                                var settings = new C.ConnectionSettings(
                                    host:
                                        'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                                    port: 3306,
                                    user: 'db_hcs',
                                    password: '20202020',
                                    db: 'hcs');

                                var conn =
                                    await C.MySqlConnection.connect(settings);

//
                                await conn.query(
                                    'insert into ${widget.category}_$type values(default,?,?)',
                                    [widget.where, setString]);
////
                                await conn.close();

                                Navigator.pop(context);
                              }),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
              ),
              actions: <Widget>[
                OutlineButton(
                  child: Text(
                    "취소",
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
              ]);
        }).then((value) => setState(() {
          widget.lan.add(setString);
        }));
  }

  Future<void> _deleteSomething(String type, List lan) {
    String setString;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "삭제할 $type을 선택해주세요.",
                style: TextStyle(
                    fontFamily: 'SCDream',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: ListView.builder(
                      itemCount: lan.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                                child: Text(
                                  lan[i],
                                  style: TextStyle(
                                      fontFamily: 'SCDream',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                onTap: () async {
                                  setState(() {
                                    setString = lan[i];
                                  });

                                  var settings = new C.ConnectionSettings(
                                      host:
                                          'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                                      port: 3306,
                                      user: 'db_hcs',
                                      password: '20202020',
                                      db: 'hcs');

                                  var conn =
                                      await C.MySqlConnection.connect(settings);

//
                                  await conn.query(
                                      'delete from ${widget.category}_$type where ${widget.category}_id=? AND ${type}_id=?',
                                      [widget.where, setString]);
                                  await conn.close();

                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      })),
              actions: <Widget>[
                OutlineButton(
                  child: Text(
                    "취소",
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
              ]);
        }).then((value) => setState(() {
          widget.lan.add(setString);
        }));
  }
}
