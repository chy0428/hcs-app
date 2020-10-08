import 'package:flutter/material.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';

class ResultCompanyReviewPage extends StatelessWidget {
  final List name;
  final List introduction;
  final List location;
  final List num_employees;
  final List working_hours;
  final List avg_sarary;
  final List review;

  ResultCompanyReviewPage(this.name, this.introduction, this.location,
      this.num_employees, this.working_hours, this.avg_sarary, this.review);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text("${name[0]}",
                      style: TextStyle(
                          fontFamily: 'SCDream',
                          fontSize: 33,
                          fontWeight: FontWeight.bold)),
                ),
                Text(
                  "${location[0]}",
                  style: TextStyle(
                    fontFamily: 'SCDream',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.person_add,
            size: 80,
            color: Colors.teal[300],
          ),
        ],
      ),
    );

    Widget introSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        "💡${introduction[0]}",
        style: TextStyle(
          fontFamily: 'SCDream',
          fontSize: 20,
        ),
        softWrap: true,
      ),
    );

    Widget infoSection = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 32),
      child: Text(
        "👥 직원 수: ${num_employees[0].toString()} 명 \n"
        "⏰ 일하는 시간: ${working_hours[0].toString()} 시간  \n"
        "💰 평균 연봉: ${avg_sarary[0].toString()} 만원 ",
        style: TextStyle(
          fontFamily: 'SCDream',
          fontSize: 20,
        ),
        softWrap: true,
      ),
    );

    Widget reviewSection = Container(
      padding: const EdgeInsets.all(32),
      child: _review(review),
    );

    return Scaffold(
      appBar: HscAppBarBack(
        context: context,
        title: Text("$name",
            style: TextStyle(
              fontFamily: 'SCDream',
              fontSize: 20,
            )),
        actions: <Widget>[],
      ),
      body: ListView(
        children: [
          titleSection,
          introSection,
          infoSection,
          reviewSection,
        ],
      ),
    );
  }
}

_review(List review) {
  for (var item in review) {
    return Text("🏢 기업 리뷰 :\n " + item,
        style: TextStyle(
          fontFamily: 'SCDream',
          fontSize: 20,
        ));
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
