import 'package:flutter/material.dart';
import 'package:hsc/login/login.dart';
import 'package:hsc/widgets/hsc_appbar.dart';
import 'package:mysql1/mysql1.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String _name;
  String _student_id;
  String _email;
  String _password;
  int isvalid = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HscAppBar(
          title: Center(
        child: Text('한동전전 회원가입', style: TextStyle(fontFamily: 'SCDream', ))
      )),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                //Todo: input design
//                Image.asset('assets/logo.png'),
                SizedBox(height: 14.0),
              ],
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Enter a name' : null;
                      },
                      onChanged: (text) {
                        _name = text;
                      },
                      decoration: InputDecoration(
//              fillColor: Colors.white,
//              filled: true,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '이름을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream', fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.length != 8 ? 'Please enter a valid student id' : null;
                      },
                      onChanged: (text) {
                        _student_id = text;
                      },
                      decoration: InputDecoration(
//              fillColor: Colors.white,
//              filled: true,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '학번을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream', fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return !value.contains('@') ? 'Please enter a valid email' : null;
                      },
                      onChanged: (text) {
                        _email = text;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '이메일을 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream', fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Enter password' : null;
                      },
                      onChanged: (text) {
                        _password = text;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: '패스워드를 입력하세요.',
                        hintStyle: TextStyle(fontFamily: 'SCDream', fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              key: _formKey,
            ),
            SizedBox(height: 30.0),
            FlatButton(
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
                      child: Text("JOIN", style: TextStyle(fontFamily: 'SCDream', fontSize: 22, color: Colors.white),
                      )
                  ),),

                onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var settings = new ConnectionSettings(
                          host:
                          'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
                          port: 3306,
                          user: 'db_hcs',
                          password: '20202020',
                          db: 'hcs');

                      var conn = await MySqlConnection.connect(settings);

                      var result = await conn.query(
                          'insert into user (name, student_id, user_email, password) values (?, ?, ?, ?)',
                          [_name, _student_id, _email, _password]);
                      print('Inserted row id=${result.insertId}');
                      await conn.close();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                }),
          ],
        ),
      ),
    );
  }
}



