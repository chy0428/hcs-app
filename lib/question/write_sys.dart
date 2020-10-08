import 'package:flutter/material.dart';
import 'package:hsc/question/qna.dart';
import 'package:mysql1/mysql1.dart';

class WriteSystemPage extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  String id;
  String content;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('시스템 문의사항 ', style: TextStyle(fontFamily: 'SCDream', color: Colors.white),
        ),
        backgroundColor: Colors.teal[200],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.length != 8 ? 'Please enter a correct student id' : null;
                      },
                      onChanged: (text) {
                        id = text;
                      },
                      decoration: InputDecoration(
                        labelText: '  학번 ',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '학번을 입력하세요 .',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return (!value.contains('@')) ? 'Please enter a valid email' : null;
                      },
                      onChanged: (text) {
                        email = text;
                      },
                      decoration: InputDecoration(
                        labelText: '  이메일 ',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '답변을 받으실 이메일을 입력하세요.',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please enter your inquiry' : null;
                      },
                      onChanged: (text) {
                        content = text;
                      },
                      decoration: InputDecoration(
                        labelText: '  문의사항 ',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '문의하실 내용을 입력하세요.',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),

                ],
              ),
              key: _formKey,
            ),

            SizedBox(height: 40.0),
            FlatButton(
                child: Container(
                  width: 500,
                  height: 45,
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
                      child: Text("등록하기 ", style: TextStyle(fontFamily: 'SCDream', fontSize: 20, color: Colors.white),
                      )
                  ),
                ),
                onPressed: () async {
                  var settings = new ConnectionSettings(
                      host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                      port: 3306,
                      user: 'db_hcs',
                      password: '20202020',
                      db: 'hcs'
                  );

                  var conn = await MySqlConnection.connect(settings);

                  var result = await conn.query(
                      'insert into sysquestion (student_id, content, stu_email) values (?, ?, ?)',
                      [id, content, email]);

                  print('Inserted row id=${result.insertId}');
                  await conn.close();

                  if (_formKey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QnAPage()),

                    );
                  }}),
          ],
        ),
      ),
    );
  }
}

