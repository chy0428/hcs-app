import 'package:flutter/material.dart';
import 'package:hsc/question/qna.dart';
import 'package:mysql1/mysql1.dart';

class WritePage extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  String id;
  String content;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일반 문의사항 ', style: TextStyle(color: Colors.white, fontFamily: 'SCDream',),
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
                        labelText: '  학번',
                        labelStyle: TextStyle(fontFamily: 'SCDream',
                        fontSize: 16, color: Colors.black),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '학번을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream',
                            fontSize: 16, color: Colors.black),
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
                        labelStyle: TextStyle(fontFamily: 'SCDream',
                            fontSize: 16, color: Colors.black),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '답변을 받으실 이메일을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream',
                            fontSize: 16, color: Colors.black),
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
                        labelStyle: TextStyle(fontFamily: 'SCDream',
                            fontSize: 16, color: Colors.black),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.teal[100])
                        ),
                        hintText: '문의하실 내용을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream',
                            fontSize: 16, color: Colors.black),
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
                      'insert into question (student_id, content, stu_email) values (?, ?, ?)',
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


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('문의하기 ',
//          style: TextStyle(color: Colors.blue),
//        ),
//        backgroundColor: Colors.white,
//      ),
//      body:
//          Container(
//            key: _formKey,
//            child: ListView(
//              children: <Widget>[
//                Padding(padding: const EdgeInsets.all(18.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      TextFormField(
//                        decoration: InputDecoration(
//                          hintText: ' handong.edu 계정 이메일을 입력해주세요. ',
//                          labelText: '  이메일 ',
//                            hintStyle: TextStyle(fontSize: 15, color: Colors.black)
//                        ),
//                        autofocus: false,
//                        onChanged: (text) {
//                          id = text;
//                        },
//                        validator: (value) {
//                          return value.isEmpty ? 'Enter ID' : null;
//                        },
//                    ),
//                    Container(
//                      margin: const EdgeInsets.only(top: 7.0),
//                      height: 300.0,
////                      decoration: BoxDecoration(
////                        border: Border.all(color: Colors.white),
////                      ),
//                      child: TextFormField(
//                        maxLines: 10,
//                        style: TextStyle(
//                            fontSize: 16.0,
//                            color: Colors.black
//                        ),
//                        decoration: InputDecoration(
//                          hintText: ' 문의 사항을 입력해 주세요.',
//                          // controller: textEditingController,
//                          border: InputBorder.none,
//                          labelText: '  내용',
//                            hintStyle: TextStyle(fontSize: 15, color: Colors.black)
//
//                        ),
//                        autofocus: false,
//
//                        validator: (value) {
//                          // ignore: missing_return
//                          if(value.isEmpty){
//                            return error;
//                          }
//                        },
//                      ),
//                    ),
//                  ],
//                )
//                ,)
//            ],
//          )
//      ),
//      floatingActionButton: FloatingActionButton.extended(
////        onPressed: () async {
////          var settings = new ConnectionSettings(
////              host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
////              port: 3306,
////              user: 'db_hcs',
////              password: '20202020',
////              db: 'hcs'
////          );
////
////          var conn = await MySqlConnection.connect(settings);
////
////          var result = await conn.query(
////              'insert into question (name, student_id, user_email, password) values (?, ?, ?, ?)',
////              [_name, _student_id, _email, _password]);
////          print('Inserted row id=${result.insertId}');
////          await conn.close();
////        },
//        icon: Icon(Icons.edit, color: Colors.white,),
//        label: Text("Post Up"),
//        backgroundColor: Colors.white,
//        foregroundColor: Colors.blue,
//      ),
//    );
//  }
//}
//