import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm1_mobile/reports/earnings/screen_table_earnings.dart';

import '../../class/screen_class_addition.dart';

class earnings extends StatefulWidget {
  const earnings({Key? key}) : super(key: key);

  @override
  State<earnings> createState() => _earningsState();
}

class _earningsState extends State<earnings> {
  TextEditingController in_date = TextEditingController();
  TextEditingController for_date = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController1 = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('ربح'),
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
                            builder: (context) => table_earnings(
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
