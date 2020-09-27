import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:hsc/question/write.dart';
import 'package:hsc/question/write_sys.dart';

class Info_Sys {
  Info_Sys(this.id, this.content, this.email);
  String id;
  String content;
  String email;
}

class QnASystemPage extends StatefulWidget {
  final List sys_info;
  QnASystemPage({this.sys_info});
  @override
  _QnASystemPageState createState() => _QnASystemPageState(sys_info: sys_info);
}

class _QnASystemPageState extends State<QnASystemPage> {
  final List sys_info;

  _QnASystemPageState({this.sys_info});

  String id;
  String content;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('\t\t 시스템 문의사항 ', style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal[200],
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.border_color,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WriteSystemPage()),
                );}
          ),
        ],
      ),
      body: ListView(
        itemExtent: 80,
        children: sys_info.map((info) => makeRowItem(context, info)).toList(),
      ),
    );
  }

  Widget makeRowItem(BuildContext ctx, Info_Sys info) {
    return Center(
      child: Container(
        color: Colors.deepOrange[50],
        child: ListTile(
          title: basic.Row(
            children: <Widget>[
              Expanded(
                child: Text(info.id,
                    style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey)),
              ),
              Container(
                child: Text(info.content,
                    style: TextStyle(fontFamily: 'SCDream',
                        fontWeight: FontWeight.bold, color: Colors.black54)),
                padding: EdgeInsets.only(left: 5.0, right: 2.0),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                ctx,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Detail(info: info)));
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  Detail({Key key, this.info}) : super(key: key);
  final Info_Sys info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(info.id+'번 문의사항'), backgroundColor: Colors.teal[200],),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  info.content,
                  style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 21.0, color: Colors.black),
                ),
              ),
              padding: EdgeInsets.all(30.0),
            ),
            Container(
              child: Center(
                child: Text('              writer: '+info.email,
                  style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black87),
                ),
              ),
              padding: EdgeInsets.only(top: 50.0),
            ),
          ],
        ),
      ),
    );
  }
}
