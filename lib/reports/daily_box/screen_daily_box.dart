import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm1_mobile/reports/daily_box/screen_table_daily_box.dart';

import '../../class/screen_class_addition.dart';
import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../main.dart';

class daily_box extends StatefulWidget {
  const daily_box({Key? key}) : super(key: key);

  @override
  State<daily_box> createState() => _daily_boxState();
}

final List<String> data = [];

bool checc1 = false;
TextEditingController _textEditingController = TextEditingController();

class _daily_boxState extends State<daily_box> {
  TextEditingController in_date = TextEditingController();
  TextEditingController for_date = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController1 = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  get_post _req = get_post();
  linkBoxD() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkBoxDaye, {
      "user_id": sharedPref.getString("id"),
      "date": formattedDate,
    });
    return response;
  }

  void initState() {
    linkBoxD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('صندوق يومية'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
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
                      future: linkBoxD(),
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
                                'الصندوق',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text(
                                          'المقبوضات',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${snapshot.data['Receipts'].toString()}",
                                          style: TextStyle(
                                            color: Colors.green,
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
                                          'المدفوعات',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${snapshot.data['Payments'].toString()}",
                                          style: TextStyle(
                                            color: Colors.red,
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'التفاصيل',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: 160,
                            child: DatePickerField(
                              dateController: _dateController,
                              labelText: 'من التاريخ',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: 160,
                            child: DatePickerField(
                              dateController: _dateController1,
                              labelText: 'الى التاريخ',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 130,
                  height: 55,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffe18505),
                      ),
                    ),
                    onPressed: () {
                      if (_dateController.text.isEmpty ||
                          _dateController1.text.isEmpty) {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          body: Center(
                            child: Text(
                              'الرجاء اختيار التاريخ',
                            ),
                          ),
                          title: 'خطأ',
                          desc: 'لم يتم اختيار التاريخ',
                        ).show();
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => table_daily_box(
                              selectedDate: _dateController.text,
                              selectedDate1: _dateController1.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('تقرير'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
