import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm1_mobile/reports/med_inventory/screen_table_med_inventory.dart';

import '../../class/screen_class_addition.dart';

class med_inventory extends StatefulWidget {
  const med_inventory({Key? key}) : super(key: key);

  @override
  State<med_inventory> createState() => _med_inventoryState();
}

final List<String> data = [];
bool checc1 = false;
int type = 0;
TextEditingController _textEditingController = TextEditingController();

class _med_inventoryState extends State<med_inventory> {
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
        title: Text('جرد مواد'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formstate,
            child: Column(
              children: [
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
                        labelText: "المادة",
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
                  height: 25,
                ),
                Text(
                  'حسب تاريخ انتهاء الصلاحية',
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
                Text(
                  'حسب الكمية',
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
                            child: tff_add_items(
                                labelText: 'اصغر من',
                                Controls: in_date,
                                type: TextInputType.number),
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
                            child: tff_add_items(
                                labelText: 'اكبر من',
                                Controls: for_date,
                                type: TextInputType.number),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
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
                      if (_dateController.text.isEmpty &&
                          _dateController1.text.isEmpty &&
                          in_date.text.isEmpty &&
                          for_date.text.isEmpty) {
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
                      } else if (_dateController.text.isNotEmpty &&
                          _dateController1.text.isNotEmpty &&
                          in_date.text.isNotEmpty &&
                          for_date.text.isNotEmpty) {
                        if (checc1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: _dateController.text,
                                  selectedDate1: _dateController1.text,
                                  num1: in_date.text,
                                  num2: for_date.text,
                                  name: '',
                                  type: 1,
                                ),
                              ));
                        } else if (_textEditingController.text.isNotEmpty) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: _dateController.text,
                                  selectedDate1: _dateController1.text,
                                  num1: in_date.text,
                                  num2: for_date.text,
                                  name: _textEditingController.text,
                                  type: 2,
                                ),
                              ));
                        }
                      } else if (_dateController.text.isNotEmpty &&
                          _dateController1.text.isNotEmpty) {
                        if (checc1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: _dateController.text,
                                  selectedDate1: _dateController1.text,
                                  num1: '',
                                  num2: '',
                                  name: '',
                                  type: 3,
                                ),
                              ));
                        } else if (_textEditingController.text.isNotEmpty) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: _dateController.text,
                                  selectedDate1: _dateController1.text,
                                  num1: '',
                                  num2: '',
                                  name: _textEditingController.text,
                                  type: 4,
                                ),
                              ));
                        }
                      } else if (in_date.text.isNotEmpty &&
                          for_date.text.isNotEmpty) {
                        if (checc1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: "",
                                  selectedDate1: "",
                                  num1: in_date.text.toString(),
                                  num2: for_date.text.toString(),
                                  name: '',
                                  type: 5,
                                ),
                              ));
                        } else if (_textEditingController.text.isNotEmpty) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => table_med_inven(
                                  selectedDate: "",
                                  selectedDate1: "",
                                  num1: in_date.text,
                                  num2: for_date.text,
                                  name: _textEditingController.text,
                                  type: 6,
                                ),
                              ));
                        }
                      } else {
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
