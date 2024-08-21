import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm1_mobile/reports/debts/screen_table_debts.dart';

import '../../class/screen_class_addition.dart';
import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../main.dart';

class debts extends StatefulWidget {
  const debts({Key? key}) : super(key: key);

  @override
  State<debts> createState() => _debtsState();
}

final List<String> data = [];
bool checc1 = false;
int checc = 0;
TextEditingController _textEditingController = TextEditingController();

class _debtsState extends State<debts> {
  TextEditingController in_date = TextEditingController();
  TextEditingController for_date = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController1 = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  get_post _req = get_post();
  linkDebtD() async {
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkDebtDaye, {
      "user_id": sharedPref.getString("id"),
      "date": formattedDate,
    });
    return response;
  }

  void initState() {
    linkDebtD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('ديون'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formstate,
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
                      future: linkDebtD(),
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
                                'الديون',
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
                                          'دائن',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${snapshot.data['total_amount_status_2'].toString()}",
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
                                          'مدين',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${snapshot.data['total_amount_status_1'].toString()}",
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
                Container(
                  margin: EdgeInsets.all(20),
                  width: screenWidth - 100,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          "كل الحسابات",
                        ),
                        value: checc1,
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          setState(() {
                            checc1 = val!;
                            if (checc1)
                              checc = 1;
                            else
                              checc = 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
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
                        labelText: "الحساب",
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
                            builder: (context) => table_debts(
                              selectedDate: _dateController.text,
                              selectedDate1: _dateController1.text,
                              ch: checc,
                              name: _textEditingController.text,
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
