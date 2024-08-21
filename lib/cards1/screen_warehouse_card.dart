import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../class/screen_class_addition.dart';
import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../home/screen_home.dart';
import '../main.dart';

class warehouse extends StatefulWidget {
  const warehouse({Key? key}) : super(key: key);

  @override
  State<warehouse> createState() => _warehouseState();
}

class _warehouseState extends State<warehouse> {
  GlobalKey<FormState> formstate = GlobalKey();
  get_post _req = get_post();
  TextEditingController Name = TextEditingController();
  TextEditingController Phone = TextEditingController();

  addSH() async {
    var response = await _req.postRequset(linkAddSH, {
      "name": Name.text,
      "phone": Phone.text,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('بطاقة مستودع'),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Form(
                key: formstate,
                child: Row(
                  children: [
                    Expanded(
                      child: tff_add_items(
                          labelText: 'اسم المستودع',
                          Controls: Name,
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: tff_add_items(
                          labelText: 'رقم المستودع',
                          Controls: Phone,
                          type: TextInputType.number),
                    ),
                  ],
                ),
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
                      addSH();
                    },
                    child: Text('اضافة'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
