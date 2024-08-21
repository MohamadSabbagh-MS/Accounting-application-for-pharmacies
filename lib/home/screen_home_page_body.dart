import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pharm1_mobile/home/screen_pie_chart.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../main.dart';

class home_page_body extends StatefulWidget {
  const home_page_body({Key? key}) : super(key: key);

  @override
  State<home_page_body> createState() => _home_page_bodyState();
}

class _home_page_bodyState extends State<home_page_body> {
  bool isKeyboardVisible = false;
  get_post _req = get_post();
  dayeR() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkDayeR, {
      "date": formattedDate,
      "user_id": sharedPref.getString("id"),
    });
    return response;
  }

  dayeE() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkDayeE, {
      "date": formattedDate,
      "user_id": sharedPref.getString("id"),
    });
    return response;
  }

  dayeB() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkDayeB, {
      "date": formattedDate,
      "user_id": sharedPref.getString("id"),
    });
    return response;
  }

  dayeD() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkDayeD, {
      "date": formattedDate,
      "user_id": sharedPref.getString("id"),
    });
    if (response['status'] == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Column(
          children: [
            Center(
              child: Text(
                'لللأسف لقد تم انتهاء صلاحية بعض المواد',
              ),
            ),
          ],
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
      //Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    dayeR();
    dayeE();
    dayeB();
    dayeD();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  'الحركة اليومية',
                  style: TextStyle(
                      color: Color(0XFF1e224c),
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.only(top: 20),
                width: screenWidth - 80,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color(0XFF1e224c),
                ),
                child: FutureBuilder(
                    future: dayeR(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == 'isEmpty') {
                          return Center(
                            child: Text(
                              "لايوجد ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              'صافي الربح',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data['data']['rebh']}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'اجمالي المبيع',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['total']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w100),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'التكلفة',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['p_price']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 17),
                width: screenWidth - 70,
                height: 250,
                child: PieChartSample2(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20),
                width: screenWidth - 80,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color(0XFF1e224c),
                ),
                child: FutureBuilder(
                    future: dayeE(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == 'isEmpty') {
                          return Center(
                            child: Text(
                              "لايوجد ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              'سندات',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'دفع',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['total_amount_statuse_2']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w100),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'قبض',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['total_amount_statuse_1']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 20),
                width: screenWidth - 80,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                  color: Color(0XFF1e224c),
                ),
                child: FutureBuilder(
                    future: dayeB(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == 'isEmpty') {
                          return Center(
                            child: Text(
                              "لايوجد ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              'فواتير',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data['data']['total']}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'مبيعات',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['salse']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w100),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'مشتريات',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${snapshot.data['data']['puch']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
