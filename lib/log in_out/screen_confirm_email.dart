import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm1_mobile/log%20in_out/screen_login.dart';

class confirm_email extends StatefulWidget {
  const confirm_email({Key? key}) : super(key: key);

  @override
  State<confirm_email> createState() => _confirm_emailState();
}

class _confirm_emailState extends State<confirm_email> {
  bool _status = false;
  bool _status1 = false;
  bool _status2 = false;
  bool _status3 = false;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Container(
              height: 325,
              child: Image(
                image: AssetImage('images/confirm.png'),
              ),
            ),
            Text(
                'ادخل الرمز المكون من 4 ارقام الذي تم ارساله\n الى بريدك الالكتروني',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Form(
                key: formstate,
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics()
                        .applyTo(AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20, right: 40),
                              width: screenWidth / 7,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      _status1 = false;
                                    });
                                  } else {
                                    setState(() {
                                      _status1 = true;
                                    });
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 40),
                                cursorColor: Color(0xffffffff),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth / 7,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      _status = false;
                                    });
                                  } else {
                                    setState(() {
                                      _status = true;
                                    });
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 40),
                                cursorColor: Color(0xffffffff),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              width: screenWidth / 7,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      _status2 = false;
                                    });
                                  } else {
                                    setState(() {
                                      _status2 = true;
                                    });
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 40),
                                cursorColor: Color(0xffffffff),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40),
                              width: screenWidth / 7,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      _status3 = false;
                                    });
                                  } else {
                                    setState(() {
                                      _status3 = true;
                                    });
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 40),
                                cursorColor: Color(0xffffffff),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_status == false ||
                                  _status1 == false ||
                                  _status2 == false ||
                                  _status3 == false) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.info,
                                  body: Center(
                                    child: Text(
                                      'يرجى  تعبئة كافة الخانات ',
                                    ),
                                  ),
                                  title: 'Agree',
                                  desc: 'Confirm Agree',
                                ).show();
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => login()));
                              }
                            },
                            child: Text(
                              "تسجيل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: "Lemonada"),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffe18505),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  30,
                                ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green.shade900,
      btnOkOnPress: onOkPress,
    ).show();
  }
}
