import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm1_mobile/reports/med_movement/screen_table_med_movement.dart';

import '../../class/screen_class_addition.dart';

class med_mov extends StatefulWidget {
  const med_mov({Key? key}) : super(key: key);

  @override
  State<med_mov> createState() => _med_movState();
}

class _med_movState extends State<med_mov> {
  final List<String> data = [];
  bool checc1 = false;

  final TextEditingController dateController = TextEditingController();
  TextEditingController in_date = TextEditingController();
  TextEditingController for_date = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
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
        title: Text('حركة مواد'),
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
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller:
                          _textEditingController, // استخدام TextEditingController
                      style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                      cursorColor: Color(0XFF1e224c),
                      // cursorHeight: 23,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabled: true,
                        labelText: "اسم المادة",
                        labelStyle: TextStyle(
                          color: Color(0XFF1e224c),
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color(0XFF1e224c),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color(0XFF1e224c),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return data
                          .where((item) => item.startsWith(pattern))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _textEditingController.text =
                            suggestion; // تحديث قيمة حقل النص
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: screenWidth - 100,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          "كل المواد",
                        ),
                        value: checc1,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc1 = val!;
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
                        if (checc1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => table_med_mov(
                                selectedDate: _dateController.text,
                                selectedDate1: _dateController1.text,
                                name: _textEditingController.text,
                                type: 1,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => table_med_mov(
                                selectedDate: _dateController.text,
                                selectedDate1: _dateController1.text,
                                name: _textEditingController.text,
                                type: 2,
                              ),
                            ),
                          );
                        }
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
