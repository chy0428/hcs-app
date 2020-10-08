import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hsc/choose/result_company.dart';
import 'package:hsc/choose/result_company_review.dart';
import 'package:hsc/widgets/hsc_appbar_back.dart';
import 'package:mysql1/mysql1.dart';

class ResultEmploymentPage extends StatelessWidget {
  final String category;
  final List list;
  final List idx;
  final List name;
  final List duration;
  final List prefer;
  final List qualification;
  final List company;

  ResultEmploymentPage(this.category, this.list, this.idx, this.name,
      this.duration, this.prefer, this.qualification, this.company);

  @override
  Widget build(BuildContext context) {
    print(
        idx[0].toString() + "," + idx[1].toString() + "," + idx[2].toString());
    return Scaffold(
      appBar: HscAppBarBack(
        context: context,
        title: Text(" 채용정보 ", style: TextStyle(fontFamily: 'SCDream')),
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index < idx[0])
                  return GestureDetector(
                      onTap: () {
                        _goToCompany(company[index].toString(), context);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.grey[300],

                          child: ListTile(
                        leading: Text(list[0]),
                            title: Text("🏢️"+" "+name[index] ,
                                style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 19)),

                            subtitle: Text(
                              "\n" + "기간: " +
                                  duration[index] +
                                  "\n" +
                                  "\n" +
                                  "선호: " +
                                  prefer[index] +
                                  "\n" +
                                  "\n" +
                                  "조건: " +
                                  qualification[index],
                              style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,

                            ),
                      )));
                else if (index < idx[1])
                  return GestureDetector(
                      onTap: () {
                        _goToCompany(company[index].toString(), context);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.grey[300],
                          child: ListTile(
                        leading: Text(list[1]),
                              title: Text("🏢️"+" "+name[index] ,
                                  style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 19)),

                              subtitle: Text(
                                "\n" + "기간: " +
                                    duration[index] +
                                    "\n" +
                                    "\n" +
                                    "선호: " +
                                    prefer[index] +
                                    "\n" +
                                    "\n" +
                                    "조건: " +
                                    qualification[index],
                                style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                      )));

                else
                  return GestureDetector(
                      onTap: () {
                        _goToCompany(company[index].toString(), context);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.grey[300],
                          child: ListTile(
                        leading: Text(list[2]),
                            title: Text("🏢️"+" "+name[index] ,
                                style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 19)),

                            subtitle: Text(
                              "\n" + "기간: " +
                                  duration[index] +
                                  "\n" +
                                  "\n" +
                                  "선호: " +
                                  prefer[index] +
                                  "\n" +
                                  "\n" +
                                  "조건: " +
                                  qualification[index],
                              style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                      )));
              },
              itemCount: name.length,
            ),
          ),
//
//
//          _getLanguage()
        ],
      ),
    );
  }

  Future _goToCompany(String companyId, BuildContext context) async {
    var name = [];
    var introduction = [];
    var location = [];
    var num_emplyees = [];
    var working_hours = [];
    var avg_salary = [];
    var review = [];
    var settings = new ConnectionSettings(
        host: 'database-1.culitdkorvr5.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'db_hcs',
        password: '20202020',
        db: 'hcs');

    var conn = await MySqlConnection.connect(settings);

    var result = await conn.query(
        'select name,introduction,location,num_employees,working_hours,avg_salary from company where company_id=${companyId.toString()}');
//                  result.
//    print("${result.toString()}");
    for (var row in result) {
      name.add(row[0]);
      introduction.add(row[1]);
      location.add(row[2]);
      num_emplyees.add(row[3]);
      working_hours.add(row[4]);
      avg_salary.add(row[5]);
    }

    var reviewResult = await conn
        .query('select review from intern where company_id=$companyId');

    if (reviewResult.isEmpty) {
      await conn.close();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultCompanyPage(name, introduction,
                location, num_emplyees, working_hours, avg_salary),
          ));
    } else {
      for (var row in reviewResult) review.add(row[0]);
      await conn.close();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultCompanyReviewPage(name, introduction,
                location, num_emplyees, working_hours, avg_salary, review),
          ));
    }
  }
}

//class MenuPage extends StatelessWidget {
//  // TODO: Make a collection of cards (102)
//
//  MenuPage();
