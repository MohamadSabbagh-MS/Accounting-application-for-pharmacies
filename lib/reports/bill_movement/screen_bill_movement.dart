import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm1_mobile/reports/bill_movement/screen_table_bill_movement.dart';

import '../../class/screen_class_addition.dart';

class bill_mov extends StatefulWidget {
  const bill_mov({Key? key}) : super(key: key);

  @override
  State<bill_mov> createState() => _daily_movState();
}

class _daily_movState extends State<bill_mov> {
  bool checc1 = false;
  bool checc2 = false;
  bool checc3 = false;
  bool checc4 = false;
  bool checc5 = false;
  bool checc6 = false;
  String c1 = 'false';
  String c2 = 'false';
  String c3 = 'false';
  String c4 = 'false';
  String c5 = 'false';
  String c6 = 'false';

  final TextEditingController dateController = TextEditingController();
  TextEditingController in_date = TextEditingController();
  TextEditingController for_date = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController1 = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('حركة فواتير'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 160,
                        child: DatePickerField(
                          dateController: _dateController,
                          labelText: 'من التاريخ',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        width: 160,
                        child: DatePickerField(
                          dateController: _dateController1,
                          labelText: 'الى التاريخ',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: screenWidth - 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0XFF1e224c), width: 2)),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          "مشتريات",
                        ),
                        value: checc1,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc1 = val!;
                            if (checc1)
                              c1 = 'true';
                            else
                              c1 = 'false';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("مبيعات"),
                        value: checc2,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc2 = val!;
                            if (checc2)
                              c2 = 'true';
                            else
                              c2 = 'false';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("سند دفع"),
                        value: checc3,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc3 = val!;
                            if (checc3)
                              c3 = 'true';
                            else
                              c3 = 'false';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("سند قبض"),
                        value: checc4,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc4 = val!;
                            if (checc4)
                              c4 = 'true';
                            else
                              c4 = 'false';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("مرتجعات"),
                        value: checc5,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc5 = val!;
                            if (checc5)
                              c5 = 'true';
                            else
                              c5 = 'false';
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("مصاريف"),
                        value: checc6,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc6 = val!;
                            if (checc6)
                              c6 = 'true';
                            else
                              c6 = 'false';
                          });
                        },
                      ),
                    ],
                  ),
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
                            builder: (context) => table_bill_mov(
                              selectedDate: _dateController.text,
                              selectedDate1: _dateController1.text,
                              chek1: c2,
                              chek2: c1,
                              chek3: c4,
                              chek4: c3,
                              chek5: c5,
                              chek6: c6,
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
