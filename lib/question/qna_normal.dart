import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:hsc/question/write.dart';

// 디테일 페이지로 넘길거
class Info {
  Info(this.id, this.content, this.email);
  String id;
  String content;
  String email;
}

class QnANormalPage extends StatefulWidget {
  final List info;
//  var infos = [
//    Info('21800700', '테스트 하는 중1', '21800758@handong.edu'),
//    Info('21800722', '테스트 하는 중2', '21800758@handong.edu'),
//    Info('21800733', '테스트 하는 중3', '21800758@handong.edu'),
//  ];
  QnANormalPage({this.info});
  @override
  _QnANormalPageState createState() => _QnANormalPageState(info: info);
}

class _QnANormalPageState extends State<QnANormalPage> {
  final List info;

  _QnANormalPageState({this.info});

  String id;
  String content;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('\t\t 일반 문의사항 ', style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, color: Colors.white),
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
                MaterialPageRoute(builder: (context) => WritePage()),
              );}
          ),
        ],
      ),
      body: ListView(
        itemExtent: 80,
        children: info.map((info) => makeRowItem(context, info)).toList(),
      ),
    );
  }

  Widget makeRowItem(BuildContext ctx, Info info) {
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
                    style: TextStyle( fontFamily: 'SCDream',
                        fontWeight: FontWeight.bold, color: Colors.black54)),
                padding: EdgeInsets.only(left: 5.0, right: 2.0),
              ),
//              Container(
//                child: Text(info.email,
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold, color: Colors.black54)),
//                padding: EdgeInsets.only(left: 12.0, right: 12.0),
//              ),
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
  final Info info;

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
