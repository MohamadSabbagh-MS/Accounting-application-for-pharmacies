import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:pharm1_mobile/class/screen_class_addition.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../home/screen_home.dart';
import '../main.dart';

class expenses extends StatefulWidget {
  _expensesState createState() => _expensesState();
}

@override
class _expensesState extends State<expenses> {
  List<String> data = [];
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textSelected1 = TextEditingController();
  TextEditingController _textSelected2 = TextEditingController();

  @override
  void dispose() {
    _textSelected1.dispose();
    _textSelected2.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  get_post _req = get_post();
  Future<void> fetchData() async {
    var response = await _req.postRequset(linkviewcus, {
      "user_id": sharedPref.getString("id"),
    });
    print("printer : ${response}");
    print(sharedPref.getString("id"));
    if (response['status'] == "success") {
      var jsonData = response['data'];
      setState(() {
        data = List<String>.from(jsonData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void initState() {
    fetchData();
    super.initState();
  }

  TextEditingController TFFC = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController des = TextEditingController();
  List<String> textList = List<String>.generate(100, (index) => ' ');

  addexp() async {
    //String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linkexp, {
      "cus_id": _textEditingController.text,
      "date": formattedDate,
      "des": des.text,
      "amount": TFFC.text,
      "user_id": sharedPref.getString("id"),
    });
    print("printer : ${response}");
    if (response['status'] == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Column(
          children: [
            Center(
              child: Text(
                'تمت الإضافة  ',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text("موافق"))
          ],
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
      //Navigator.pop(context);
    } else if (response['status'] == "isEmpty") {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: const Center(
          child: Text(
            ' لايوجد هذا الدواء في المخزن',
          ),
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Center(
          child: Text(
            'عذرا حدث خطأ يرجى عادة المحاولة ',
          ),
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('مصاريف'),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller:
                            _textEditingController, // استخدام TextEditingController
                        style:
                            TextStyle(color: Color(0XFF1e224c), fontSize: 15),
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
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 59,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0XFF1e224c), width: 2),
                      ),
                      child: Text(formattedDate,
                          style: TextStyle(
                              color: Color(0XFF1e224c), fontSize: 20)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextFormField(
                  // controller: _textSelected3,
                  minLines: 1,
                  maxLines: 7,
                  style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                  cursorColor: Color(0XFF1e224c),
                  cursorHeight: 23,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabled: true,
                    labelText: 'تفاصيل',
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
                  controller: des,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: tff_add_items(
                    labelText: 'المبلغ',
                    Controls: TFFC,
                    type: TextInputType.number),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffe18505),
                        ),
                      ),
                      onPressed: () {
                        addexp();
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffe18505),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Text('إلغاء'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
