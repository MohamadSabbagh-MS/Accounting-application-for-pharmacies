import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pharm1_mobile/about/screen_about_application.dart';
import 'package:pharm1_mobile/about/screen_about_us.dart';
import 'package:pharm1_mobile/bill/screen_purchases_bill.dart';
import 'package:pharm1_mobile/cards1/edit_card/screen_accessory_edit.dart';
import 'package:pharm1_mobile/cards1/edit_card/screen_medicine_edit.dart';
import 'package:pharm1_mobile/cards1/screen_customer_card.dart';
import 'package:pharm1_mobile/cards1/screen_damaged_materials.dart';
import 'package:pharm1_mobile/home/screen_home_page_body.dart';
import 'package:pharm1_mobile/log%20in_out/screen_login.dart';
import 'package:pharm1_mobile/main.dart';
import 'package:pharm1_mobile/model/new2.dart';
import 'package:pharm1_mobile/reports/earnings/screen_earnings.dart';

import '../bill/payment_receipt.dart';
import '../bill/screen_expenses.dart';
import '../bill/screen_purchase_returns.dart';
import '../bill/screen_receipts.dart';
import '../bill/screen_sales_bill.dart';
import '../bill/screen_sales_returns.dart';
import '../cards1/screen_accessory_card.dart';
import '../cards1/screen_employee_card.dart';
import '../cards1/screen_insurance_company_card.dart';
import '../cards1/screen_medicine_card.dart';
import '../cards1/screen_warehouse_card.dart';
import '../reports/bill_movement/screen_bill_movement.dart';
import '../reports/daily_box/screen_daily_box.dart';
import '../reports/daily_movement/screen_daily_movement.dart';
import '../reports/debts/screen_debts.dart';
import '../reports/med_inventory/screen_med_inventory.dart';
import '../reports/med_movement/screen_med_movement.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ExpansionTileController controller1 = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();
  final ExpansionTileController controller3 = ExpansionTileController();
  final ExpansionTileController controller4 = ExpansionTileController();
  final ExpansionTileController controller5 = ExpansionTileController();
  bool select1 = false;
  bool select2 = false;
  bool select3 = false;
  bool select4 = false;
  bool select5 = false;
  GlobalKey<ScaffoldState> opendrawe = new GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: opendrawe,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image(
                image: AssetImage('images/logo1.png'),
              ), //Text('القائمة'),
              //decoration: BoxDecoration(
              // color: Colors.blue,
              //),
            ),
            Container(
              child: ExpansionTile(
                controller: controller1,
                // textColor: Colors.white,

                iconColor: Color(0XFF1e224c),
                leading: Icon(
                  Icons.backup_table_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  'فاتورة',
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onExpansionChanged: (bool oEC) {
                  setState(() {
                    if (oEC) {
                      controller2.collapse();
                      controller3.collapse();
                      controller4.collapse();
                    }
                  });
                },
                initiallyExpanded: select1,
                children: [
                  ListTile(
                    title: Text('مبيعات',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => sales()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('مشتريات',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => purchases()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('مرتجع مبيعات',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => sales_r()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('مرتجع مشتريات',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => purchases_r()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('مصاريف',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => expenses()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('سند دفع',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => payment_receipt()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('سند قبض',
                        style: TextStyle(
                          color: Color(0XFF1e224c),
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => receipts()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ExpansionTile(
                controller: controller2,
                //  textColor: Color(0XFF1e224c),
                iconColor: Color(0XFF1e224c),
                leading: Icon(
                  Icons.sanitizer_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  'مواد',
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                children: [
                  ListTile(
                    title: Text('دواء',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => medicine()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('اكسسوار',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => accessory()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('تعديل دواء',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => med_edit()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('تعديل اكسسوار',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => acc_edit()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('مواد تالفة',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => damaged_mat()),
                      );
                    },
                  ),
                ],
                initiallyExpanded: select2,
                onExpansionChanged: (bool oEC) {
                  setState(() {
                    if (oEC) {
                      controller1.collapse();

                      controller3.collapse();
                      controller4.collapse();
                    }
                  });
                },
              ),
            ),
            Container(
              child: ExpansionTile(
                controller: controller3,
                //textColor: Color(0xffe18505),
                iconColor: Color(0XFF1e224c),
                leading: Icon(
                  Icons.switch_account_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  'حسابات',
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                children: [
                  ListTile(
                    title: Text('زبون',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => customer()),
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Text('كشف حساب زبون',
                  //       style: TextStyle(color: Color(0XFF1e224c)),
                  //       textAlign: TextAlign.center),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => statement()),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    title: Text('موظف',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => employee()),
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Text('كشف حساب موظف',
                  //       style: TextStyle(color: Color(0XFF1e224c)),
                  //       textAlign: TextAlign.center),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => statement()),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    title: Text('شركة تأمين',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => insurance_company()),
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Text('كشف حساب شركة تأمين',
                  //       style: TextStyle(color: Color(0XFF1e224c)),
                  //       textAlign: TextAlign.center),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => statement()),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    title: Text('مستودع',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => warehouse()),
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Text('كشف حساب مستودع',
                  //       style: TextStyle(color: Color(0XFF1e224c)),
                  //       textAlign: TextAlign.center),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => statement()),
                  //     );
                  //   },
                  // ),
                ],
                initiallyExpanded: select3,
                onExpansionChanged: (bool oEC) {
                  setState(() {
                    if (oEC) {
                      controller1.collapse();
                      controller4.collapse();
                      controller2.collapse();
                    }
                  });
                },
              ),
            ),
            Container(
              child: ExpansionTile(
                controller: controller4,
                //textColor: Color(0xffe18505),
                iconColor: Color(0XFF1e224c),
                leading: Icon(
                  Icons.insert_chart_outlined_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  'تقارير عامة',
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                children: [
                  ListTile(
                    title: Text('حركة اليومية',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => daily_mov()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('حركة المواد',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => med_mov()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('حركة الفواتير',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => bill_mov()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('دائن/مدين',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => debts()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('صندوق اليومية',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => daily_box()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('جرد مواد',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => med_inventory()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('ربح',
                        style: TextStyle(color: Color(0XFF1e224c)),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => earnings()),
                      );
                    },
                  ),
                ],
                onExpansionChanged: (bool oEC) {
                  setState(() {
                    if (oEC) {
                      controller1.collapse();
                      controller3.collapse();
                      controller2.collapse();
                    }
                  });
                },
                initiallyExpanded: select4,
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.quiz_outlined,
                  color: Color(0XFF1e224c),
                ),
                textColor: Colors.black,
                title: Text(
                  "من نحن ",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => about_us()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                textColor: Colors.black,
                leading: Icon(
                  Icons.phone_android_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  "عن التطبيق",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => about_app()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                textColor: Colors.black,
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  "تسجيل خروج",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  sharedPref.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
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
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(
                      color: Color(0XFF1e224c),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child:
                      home_page_body(), // استخدام Positioned.fill بدلاً من تحديد عرض وارتفاع الـ Container
                ),
                Positioned(
                  bottom: 33,
                  left: 320,
                  child: botton1(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
