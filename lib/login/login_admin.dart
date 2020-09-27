// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:hsc/login/join_admin.dart';
import 'package:hsc/utils/colors.dart';
import 'package:mysql1/mysql1.dart';

import 'admin.dart';
import 'login.dart';

//import 'resister.dart';

class LoginAdminPage extends StatefulWidget {
  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _id;
  String _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text('한동전전 ver.admin',
                  style: TextStyle(
                    fontFamily: 'SCDream',
                  )))),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
//                Image.asset('assets/logo.png'),
                SizedBox(height: 16.0),
              ],
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Enter Contents' : null;
                      },
                      onChanged: (text) {
                        _id = text;
                      },
                      decoration: InputDecoration(
//              fillColor: Colors.white,
//              filled: true,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '학번을 입력하세요.',
                        hintStyle: TextStyle(
                            fontFamily: 'SCDream',
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        return value.isEmpty ? 'Enter Contents' : null;
                      },
                      onChanged: (text) {
                        _password = text;
                      },
                      decoration: InputDecoration(
//              fillColor: Colors.white,
//              filled: true,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '패스워드를 입력하세요.',
                        hintStyle: TextStyle(
                            fontFamily: 'SCDream',
                            fontSize: 15,
                            color: Colors.black),
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
                      child: Text(
                    "로그인 ",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
                onPressed: () async {
                  var settings = new ConnectionSettings(
                      host:
                          'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                      port: 3306,
                      user: 'db_hcs',
                      password: '20202020',
                      db: 'hcs');

                  var conn = await MySqlConnection.connect(settings);

                  var result = await conn.query(
                      'select admin_pw,category_id from admin where student_id = ?',
                      [_id]);
//                  result.
                  var pw;
                  var where;
                  for (var row in result) {
                    pw = row[0];
                    where = row[1];
                  }

                  if (_formKey.currentState.validate() &&
                      pw.toString() == _password) {
                    var name = " ";
                    var introduction = " ";
                    var prof = " ";
                    var category;

                    if (where == null) {
                      _wait();
                    } else {
                      if (where < 10)
                        category = "academy";
                      else if (where < 100)
                        category = "lab";
                      else
                        category = "club";

                      var result2 = await conn.query(
                          'select name,introduction,professor from $category where ${category}_id = ?',
                          [where]);

                      for (var row in result2) {
                        name = row[0];
                        introduction = row[1];
                        prof = row[2];
                      }

                      var db = [];
                      var lan = [];
                      var frame = [];

                      var resultLan = await conn.query(
                          'select language_id from ${category}_language where ${category}_id= ?',
                          [where]);

                      for (var row in resultLan) {
                        lan.add(row[0]);
                      }
                      var resultDb = await conn.query(
                          'select database_id from ${category}_database where ${category}_id= ?',
                          [where]);

                      for (var row in resultDb) {
                        db.add(row[0]);
                      }

                      var resultFrame = await conn.query(
                          'select framework_id from ${category}_framework where ${category}_id= ?',
                          [where]);

                      for (var row in resultFrame) {
                        frame.add(row[0]);
                      }
                      await conn.close();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminPage(
                                category: category,
                                name: name,
                                introduction: introduction,
                                prof: prof,
                                where: where,
                                lan: lan,
                                db: db,
                                framework: frame)),
                      );
                    }
                  } else {
                    await _wrong();
                  }
                }),
            SizedBox(
              height: 5,
            ),
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
                      child: Text(
                    "관리자 회원가입 ",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinAdminPage()),
                  );
                }),
            SizedBox(
              height: 40,
            ),
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
                      child: Text(
                    "일반유저 로그인",
                    style: TextStyle(
                        fontFamily: 'SCDream',
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _wait() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "권한을 확인 중 입니다.",
              style: TextStyle(
                  fontFamily: 'SCDream',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            actions: <Widget>[
              OutlineButton(
                child: Text(
                  "확인",
                  style: TextStyle(
                      fontFamily: 'SCDream',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                borderSide: BorderSide(style: BorderStyle.none),
                onPressed: () {
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

  Future<void> _wrong() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "아이디 또는 비밀번호가 일치하지 않습니다.",
              style: TextStyle(
                  fontFamily: 'SCDream',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            actions: <Widget>[
              OutlineButton(
                child: Text(
                  "확인",
                  style: TextStyle(
                      fontFamily: 'SCDream',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                borderSide: BorderSide(style: BorderStyle.none),
                onPressed: () {
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
}
