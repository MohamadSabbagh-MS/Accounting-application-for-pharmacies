import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm1_mobile/log%20in_out/screen_confirm_email.dart';
import 'package:pharm1_mobile/log%20in_out/screen_login.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';

class logout extends StatefulWidget {
  const logout({Key? key}) : super(key: key);

  @override
  State<logout> createState() => _logoutState();
}

class _logoutState extends State<logout> {
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  bool _obscureText = true;
  bool _status = false;
  bool _status1 = false;
  bool _status2 = false;
  get_post _req = get_post();
  signUp() async {
    // String pass=await FlutterEncryptPlus.e
    var response = await _req.postRequset(linkSignUp, {
      "email": email.text,
      "password": password1.text,
    });
    print("printer : ${response}");
    if (response['status'] == "success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => confirm_email()));
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          color: Color(0XFF1e224c),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "انشاء حساب ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lemonada"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("أهلاً بك",
                            style: TextStyle(
                                color: Color(0xfafafafa),
                                fontSize: 15,
                                fontFamily: "Lemonada")),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: Form(
                  key: formstate,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics()
                          .applyTo(AlwaysScrollableScrollPhysics()),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                controller: email,
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
                                    color: Color(0xff415a77), fontSize: 20),
                                cursorColor: Color(0xff778da9),
                                cursorHeight: 27,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xff778da9),
                                  ),
                                  enabled: true,
                                  labelText: " البريد الالكتروني",
                                  labelStyle: TextStyle(
                                    color: Color(0xff778da9),
                                    fontSize: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                controller: password1,
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
                                obscureText: _obscureText,
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 20),
                                cursorColor: Color(0xff778da9),
                                cursorHeight: 27,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xff778da9),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_obscureText == true)
                                            _obscureText = false;
                                          else
                                            _obscureText = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Color(0xff778da9),
                                      )),
                                  enabled: true,
                                  labelText: " كلمة المرور",
                                  labelStyle: TextStyle(
                                    color: Color(0xff778da9),
                                    fontSize: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 15)),
                              ]),
                              child: TextFormField(
                                controller: password2,
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
                                obscureText: _obscureText,
                                style: TextStyle(
                                    color: Color(0xff415a77), fontSize: 20),
                                cursorColor: Color(0xff778da9),
                                cursorHeight: 27,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xff778da9),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_obscureText == true)
                                            _obscureText = false;
                                          else
                                            _obscureText = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Color(0xff778da9),
                                      )),
                                  enabled: true,
                                  labelText: "تأكيد كلمة المرور",
                                  labelStyle: TextStyle(
                                    color: Color(0xff778da9),
                                    fontSize: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(27),
                                    borderSide: BorderSide(
                                      color: Color(0xff415a77),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_status == true &&
                                      _status1 == true &&
                                      _status2 == true) {
                                    if (password1.text == password2.text) {
                                      FocusScope.of(context).unfocus();
                                      signUp();
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.info,
                                        body: Center(
                                          child: Text(
                                            'كلمة السر غير متطابقة!',
                                          ),
                                        ),
                                        title: 'Agree',
                                        desc: 'Confirm Agree',
                                      ).show();
                                    }
                                  } else if (_status == false &&
                                      _status1 == false &&
                                      _status2 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال البريد الالكتروني  و كلمة المرور و تأكيد كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status1 == false &&
                                      _status2 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال كلمة المرور و تأكيد كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status == false &&
                                      _status1 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال البريد الالكتروني و كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status == false &&
                                      _status2 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال البريد الالكتروني و تأكيد كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال البريد الالكتروني !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status1 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  } else if (_status2 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى  تأكيد كلمة المرور !',
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  }
                                },
                                child: Text(
                                  "انشاء",
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
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      ' لديك بالفعل حساب؟',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => login()));
                                      },
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
