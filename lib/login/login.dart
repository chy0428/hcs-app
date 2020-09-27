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
import 'package:hsc/choose/choose_menu.dart';
import 'package:hsc/login/join.dart';
import 'package:hsc/login/login_admin.dart';
import 'package:hsc/utils/colors.dart';
import 'package:mysql1/mysql1.dart';
//import 'resister.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          child: Text('한동전전',
              style: TextStyle(
                fontFamily: 'SCDream',
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Enter ID' : null;
                      },
                      onChanged: (text) {
                        _id = text;
                      },
                      decoration: InputDecoration(
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
                        return value.isEmpty ? 'Enter Password' : null;
                      },
                      onChanged: (text) {
                        _password = text;
                      },
                      decoration: InputDecoration(
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
            ),
            const SizedBox(height: 50.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
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
                        'select password from user where student_id = ?',
                        [_id]);
                    var value;
                    for (var row in result) {
                      value = row[0];
                    }
                    await conn.close();

                    if (_formKey.currentState.validate() &&
                        value.toString() == _password) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    } else {
                      await _wrong();
                    }
                  },
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
                      "로그인",
                      style: TextStyle(
                          fontFamily: 'SCDream',
                          fontSize: 20,
                          color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage()),
                    );
                  },
                  child: Container(
                    width: 400,
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
                    //padding: const EdgeInsets.all(10.0),

                    child: Center(
                        child: Text(
                      "회원가입",
                      style: TextStyle(
                          fontFamily: 'SCDream',
                          fontSize: 20,
                          color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(height: 40),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginAdminPage()),
                    );
                  },
                  child: Container(
                    width: 400,
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
                      "관리자 모드 로그인 ",
                      style: TextStyle(
                          fontFamily: 'SCDream',
                          fontSize: 20,
                          color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          );
        });
  }
}
