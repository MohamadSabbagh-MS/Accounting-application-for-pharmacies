import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharm1_mobile/log%20in_out/screen_logout.dart';
import 'package:pharm1_mobile/main.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../home/screen_home.dart';
import '../model/model_login.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late final loginModel loginmodel;
  late final Data logindata;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  bool _obscureText = true;
  bool _status = false;
  bool _status1 = false;
  get_post _req = get_post();
  logIn() async {
    var response = await _req.postRequset(linkLogin, {
      "email": email.text,
      "password": password.text,
    });
    // print("printer : ${response}");
    if (response['status'] == "success") {
      print(response['data']);
      print(password.text);
      if (response['data']['par_pass'].toString() == password.text.toString()) {
        sharedPref.setString("id", response['data']['par_id'].toString());
        sharedPref.setString("email", response['data']['par_email']);
        sharedPref.setString("password", response['data']['par_pass']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: Center(
            child: Text(
              'كلمة المرور خطأ ',
            ),
          ),
          title: 'Agree',
          desc: 'Confirm Agree',
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        body: Center(
          child: Text(
            'خطأ , تأكد من المعلومات المدخلة ',
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
                          "تسجيل الدخول",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lemonada"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("أهلاً بعودتك",
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
                                controller: password,
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
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.noHeader,
                                      body: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration:
                                                    BoxDecoration(boxShadow: [
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
                                                      color: Color(0xff415a77),
                                                      fontSize: 20),
                                                  cursorColor:
                                                      Color(0xff778da9),
                                                  cursorHeight: 27,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    prefixIcon: Icon(
                                                      Icons.email,
                                                      color: Color(0xff778da9),
                                                    ),
                                                    enabled: true,
                                                    labelText:
                                                        " البريد الالكتروني",
                                                    labelStyle: TextStyle(
                                                      color: Color(0xff778da9),
                                                      fontSize: 20,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              27),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff415a77),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              27),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff415a77),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 100,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "تم ارسال كلمة المرور الى الايميل",
                                                    );
                                                  },
                                                  child: Text('إرسال'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xffe18505),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                            30,
                                                          ))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      title: 'Agree',
                                      desc: 'Confirm Agree',
                                    ).show();
                                  },
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ),
                              ),
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
                                onPressed: () async {
                                  if (_status == true && _status1 == true) {
                                    FocusScope.of(context).unfocus();
                                    await logIn();
                                  } else if (_status == false &&
                                      _status1 == false) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      body: Center(
                                        child: Text(
                                          'يرجى إدخال البريد الالكتروني  و كلمة المرور !',
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
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'ليس لديك حساب؟',
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
                                                builder: (context) =>
                                                    logout()));
                                      },
                                      child: Text(
                                        'انشاء حساب',
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
              ),
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
