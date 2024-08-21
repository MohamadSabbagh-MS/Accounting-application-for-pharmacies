import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pharm1_mobile/home/screen_home_page_body.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  GlobalKey<ScaffoldState> opendrawe = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: opendrawe,
      drawer: Drawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          opendrawe.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Color(0XFF1e224c),
                          size: 30,
                        )),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'الصفحة الرئيسية',
                      style: TextStyle(
                          color: Color(0XFF1e224c),
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight - 100,
              child: home_page_body(),
            ),
          ],
        ),
      ),
    );
  }
}
