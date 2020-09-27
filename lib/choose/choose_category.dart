import 'package:flutter/material.dart';
import 'package:hsc/utils/colors.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';

class CategoryPage extends StatelessWidget {
  final String choose;

  CategoryPage(this.choose);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HscAppBarBack(
        context: context,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: GestureDetector(
//                onTap: ,
                child: Container(
                    margin: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                            BorderSide(width: 5, color: mainColor))),
                    child: Center(
                      child: Text(
                        "언어",
                        style: TextStyle(fontSize: 40),
                      ),
                    )),
              )),
          Flexible(
            flex: 1,
            child: Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(width: 5, color: mainColor))),
                child: Center(
                  child: Text(
                    "데이터베이스",
                    style: TextStyle(fontSize: 40),
                  ),
                )),
          ),
          Flexible(
            flex: 1,
            child: Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(width: 5, color: mainColor))),
                child: Center(
                  child: Text(
                    "프레임워크",
                    style: TextStyle(fontSize: 40),
                  ),
                )),
          ),

//          _getLanguage()
        ],
      ),
    );
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
