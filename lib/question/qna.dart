import 'package:flutter/material.dart';
import 'package:hsc/question/qna_normal.dart';
import 'package:hsc/question/qna_system.dart';
import 'package:mysql1/mysql1.dart';

class QnAPage extends StatelessWidget {
  String id;
  String content;
  String email;
  List info = [];
  List sys_info = [];

  Future QnA() async {
    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');
    var conn = await MySqlConnection.connect(settings);

    var result = await conn
        .query('select question_id, content, stu_email from question');

    for (var row in result) {
      print('question_id: ${row[0]}, content: ${row[1]}, email: ${row[2]}');
      id = row[0].toString();
      content = row[1];
      email = row[2];
      Info element = Info(id, content, email);
      info.add(element);
    }
  }


  Future QnA_Sys() async {
    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');
    var conn = await MySqlConnection.connect(settings);

    var result = await conn
        .query('select sysquestion_id, content, stu_email from sysquestion');

    for (var row in result) {
      print('sysquestion_id: ${row[0]}, content: ${row[1]}, email: ${row[2]}');
      id = row[0].toString();
      content = row[1];
      email = row[2];
      Info_Sys element = Info_Sys(id, content, email);
      sys_info.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문의하기 ', style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal[200],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                //Todo: input design
//                Image.asset('assets/logo.png'),
                SizedBox(height: 14.0),
              ],
            ),
            SizedBox(
                height: 170.0,
                child: RaisedButton(
                    child: Text("일반 문의 사항 ", style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 22)),
                    color: Colors.lime[100],
                    onPressed: () async {
                      await QnA();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QnANormalPage(info: info)),
                      );
                    })),
            SizedBox(height: 30.0),
            SizedBox(
                height: 170.0,
                child: RaisedButton(
                    child: Text("시스템 문의 사항 ", style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 22)),
                    color: Colors.lightGreen[100],
                    onPressed: () async{
                      await QnA_Sys();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QnASystemPage(sys_info: sys_info)),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

//
//
