import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharm1_mobile/class/screen_class_addition.dart';
import 'package:pharm1_mobile/table/screen_table_input_1.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../home/screen_home.dart';
import '../main.dart';

class damaged_mat extends StatefulWidget {
  _damaged_matState createState() => _damaged_matState();
}

@override
class _damaged_matState extends State<damaged_mat> {
  String? scannedValue;
  TextEditingController barcode = TextEditingController();
  TextEditingController number = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  get_post _req = get_post();

  addtalef() async {
    //String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedDate = '${DateTime.now().year}-'
        '${DateTime.now().month.toString().padLeft(2, '0')}-'
        '${DateTime.now().day.toString().padLeft(2, '0')}';
    var response = await _req.postRequset(linktalef, {
      "name": barcode.text,
      "date": formattedDate,
      "num": number.text,
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
        title: Text('مواد تالفة'),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: barcode,
                  //TextEditingController(text: scannedValue),
                  style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                  cursorColor: Color(0XFF1e224c),
                  cursorHeight: 23,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        color: Color(0xff778da9),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRViewExample()),
                        );
                        setState(() {
                          barcode.text = result as String? ?? '';
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabled: true,
                    labelText: " باركود",
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
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: tff_add_items(
                          labelText: 'العدد',
                          Controls: number,
                          type: TextInputType.number),
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
                          border:
                              Border.all(color: Color(0XFF1e224c), width: 2),
                        ),
                        child: Text(formattedDate,
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffe18505),
                        ),
                      ),
                      onPressed: () {
                        if (barcode.text.isEmpty || number.text.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.info,
                            body: Center(
                              child: Text(
                                'يرجى تعبئة كافة الحقول',
                              ),
                            ),
                            title: 'خطأ',
                            desc: 'لم يتم اختيار التاريخ',
                          ).show();
                        } else {
                          addtalef();
                        }
                      },
                      child: Text('اضافة'),
                    ),
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
