import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:pharm1_mobile/table/screen_table_input_1.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../home/screen_home.dart';
import '../main.dart';
import '../table/screen_table_data_helper_purchases.dart';

class purchases extends StatefulWidget {
  _purchasesState createState() => _purchasesState();
}

@override
class _purchasesState extends State<purchases> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();

  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  List<String> data = [];
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textSelected1 = TextEditingController();
  TextEditingController _textSelected2 = TextEditingController();
  TextEditingController _textSelected3 = TextEditingController();
  TextEditingController _textSelected4 = TextEditingController();
  TextEditingController _textSelected5 = TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

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
    controllerm = List.generate(13, (index) => TextEditingController());
    controllerC = List.generate(13, (index) => TextEditingController());
    controllerPack = List.generate(13, (index) => TextEditingController());
    controllerphf = List.generate(13, (index) => TextEditingController());
    controllerprice = List.generate(13, (index) => TextEditingController());
    controllerH = List.generate(13, (index) => TextEditingController());
    controllerHasem = List.generate(13, (index) => TextEditingController());
    _dateController = List.generate(13, (index) => TextEditingController());

    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
  }

  late String? _selectedOption = null;
  // bool _isReadOnly = false;

  final TextEditingController accountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController med = TextEditingController();
  List<TextEditingController> controllerm = [];
  List<TextEditingController> controllerC = [];
  List<TextEditingController> controllerPack = [];
  List<TextEditingController> controllerphf = [];
  List<TextEditingController> controllerprice = [];
  List<TextEditingController> controllerH = [];
  List<TextEditingController> controllerHasem = [];
  List<TextEditingController> _dateController = [];
  List<String> datacont = ['', '', '', '', '', '', '', '', '', ''];
  List<String> textList = List<String>.generate(100, (index) => ' ');
  @override
  Map<String, dynamic> data1 = {};
  void updateData(String key, dynamic value) {
    setState(() {
      data1[key] = value;
    });
  }

  List<int> amountAll = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> amountH = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int amountallA = 0;
  int amountallH = 0;
  Map<String, dynamic> data2 = {};
  void updateData1(String key, dynamic value) {
    setState(() {
      data2[key] = value;
    });
  }

  List<Map> dataList = [];
  void addData(dynamic value) {
    setState(() {
      dataList.add(value);
    });
  }

  Map<String, dynamic> MedData = {};
  Future<void> GetMed() async {
    var response = await _req.postRequset(linkSelectM, {
      "name": med.text,
      "user_id": sharedPref.getString("id"),
    });
    print("printer : ${response}");
    if (response['status'] == "success") {
      var jsonData = response['data'];
      setState(() {
        MedData = jsonData;
        print("MedData : ${MedData}");
        print("MedData : ${MedData['caliber']}");
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> s() async {
    try {
      print("daadadada ${jsonEncode(data1)}");
      var x = jsonEncode(data1);
      Map<String, dynamic>? responseData =
          await _req.postRequest1(linkSendJson, data1);
      print(
          responseData); // يمكنك تعديل هذا الجزء بناءً على استجابة الـ API الفعلية لك
      if (responseData?["status"] == "success") {
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
          body: Column(
            children: [
              Center(
                child: Text(
                  'حدث خطأ يرجى التأكد من المعلومات وإعادة المحاولة ',
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
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('فاتورة مشتريات'),
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
                            updateData("cus_id", suggestion);
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
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(20),

                          isDense: true,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "اختر نوع الفاتورة",
                            labelStyle: TextStyle(
                              color: Color(0XFF1e224c),
                              fontSize: 15,
                            ),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0XFF1e224c),
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0XFF1e224c),
                                width: 2,
                              ),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0XFF1e224c),
                          ),
                          //alignment: Alignment.topCenter,
                          value: _selectedOption,
                          items: [
                            DropdownMenuItem(
                              value: 'option1',
                              child: Text(
                                'نقدا',
                                style: TextStyle(
                                  color: Color(0XFF1e224c),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'option2',
                              child: Text(
                                'مؤجل',
                                style: TextStyle(
                                  height: 1,
                                  color: Color(0XFF1e224c),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                              //_isReadOnly = value == 'option1';
                              if (value == 'option1') {
                                _textSelected1.text = '';
                                _textSelected2.text = '';
                              } // إعداد حالة القراءة فقط
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style:
                            TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                        cursorColor: Color(0XFF1e224c),
                        cursorHeight: 23,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabled: true,
                          labelText: " رقم الفاتورة",
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
                        onChanged: (text) {
                          updateData("num_bill", text);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Container(
                  width: screenWidth - 32,
                  height: screenHeight - 515,
                  child: Scaffold(
                    body: SafeArea(
                      child: Stack(
                        children: [
                          tableContent(),
                          tableHeader(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color(0xffffffff),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            controller: _textSelected4,
                            readOnly: true,
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 15),
                            cursorColor: Color(0XFF1e224c),
                            cursorHeight: 23,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabled: true,
                              labelText: "المبلغ الكلي",
                              labelStyle: TextStyle(
                                color: Color(0XFF1e224c),
                                fontSize: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                //  borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _textSelected1,
                            //     readOnly: _isReadOnly,
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 15),
                            cursorColor: Color(0XFF1e224c),
                            cursorHeight: 15,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabled: true,
                              labelText: "المدفوع",
                              labelStyle: TextStyle(
                                color: Color(0XFF1e224c),
                                fontSize: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                //  borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //    borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (x) {
                              if (int.parse(x) >
                                  int.parse(_textSelected4.text)) {
                                _textSelected1.text = _textSelected4.text;
                                _textSelected2.text =
                                    (int.parse(_textSelected4.text) -
                                            int.parse(_textSelected1.text))
                                        .toString();
                              } else {
                                _textSelected2.text =
                                    (int.parse(_textSelected4.text) -
                                            int.parse(_textSelected1.text))
                                        .toString();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _textSelected2,
                            //   readOnly: _isReadOnly,
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 15),
                            cursorColor: Color(0XFF1e224c),
                            cursorHeight: 15,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabled: true,
                              labelText: "الباقي",
                              labelStyle: TextStyle(
                                color: Color(0XFF1e224c),
                                fontSize: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0XFF1e224c),
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (v) {
                              print("الباقي" + v);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
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
                          print("List is : ${dataList}");
                          updateData("amount", _textSelected4.text);
                          updateData(
                              "amount_paid",
                              _textSelected1.text.isEmpty
                                  ? "0"
                                  : _textSelected1.text);
                          updateData(
                              "remaining_amount",
                              _textSelected2.text.isEmpty
                                  ? "0"
                                  : _textSelected2.text);
                          updateData("discount_v", amountallH);
                          updateData("sales", dataList);
                          updateData(
                              "discount",
                              ((amountallH * 100) /
                                      int.parse(_textSelected4.text))
                                  .ceil());
                          updateData("user_id", sharedPref.getString("id"));
                          updateData("amount_discount",
                              int.parse(_textSelected4.text) - amountallH);
                          updateData(
                              "date",
                              '${DateTime.now().year}-'
                                  '${DateTime.now().month.toString().padLeft(2, '0')}-'
                                  '${DateTime.now().day.toString().padLeft(2, '0')}');

                          print("data end : ${data1}");
                          s();
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
      ),
    );
  }

  Widget tableContent() {
    return SingleChildScrollView(
      child: Row(
        children: [
          // start

          DataTable(
            columnSpacing: 0,
            horizontalMargin: 0,
            columns: TableDataHelper_p.kTableColumnsList
                .getRange(TableDataHelper_p.kTableColumnsList.length - 1,
                    TableDataHelper_p.kTableColumnsList.length)
                .map((e) {
              return DataColumn(
                label: SizedBox(
                  child: Text(e.title ?? '', textAlign: TextAlign.center),
                  width: e.width ?? 0,
                ),
              );
            }).toList(),
            // headingRowColor: MaterialStateProperty.all(Colors.orange),
            dataRowColor: MaterialStateProperty.all(Colors.orange.shade100),
            rows: List.generate(10, (index) {
              return DataRow(cells: [
                DataCell(
                  SizedBox(
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                    ),
                    width: TableDataHelper_p.kTableColumnsList.last.width,
                  ),
                )
              ]);
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: dataScrollController,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: 0,
                //headingRowColor: MaterialStateProperty.all(Colors.green),
                //dataRowColor: MaterialStateProperty.all(Colors.blue.shade100),
                columns: TableDataHelper_p.kTableColumnsList
                    .getRange(1, TableDataHelper_p.kTableColumnsList.length - 1)
                    .map((e) {
                  return DataColumn(
                    label: SizedBox(
                      child: Text(e.title ?? ''),
                      width: e.width ?? 0,
                    ),
                  );
                }).toList(),
                rows: List.generate(10, (index) {
                  return DataRow(
                      color: index % 2 == 1
                          ? MaterialStateColor.resolveWith(
                              (states) => Colors.orange.shade100,
                            )
                          : MaterialStateColor.resolveWith(
                              (states) => Color(0xfff3f1f0),
                            ),
                      cells: [
                        DataCell(
                          SizedBox(
                            child: table_input(
                              ontap: (x) {
                                med.text = x;
                                GetMed();

                                Future.delayed(Duration(seconds: 1), () {
                                  if (index != 0 && data2 != null) {
                                    print("list = ${dataList}");
                                  }
                                  _textSelected3.text = x;
                                  updateData1("id_med", x);
                                  controllerC[index].text =
                                      MedData["caliber"].toString();
                                  controllerprice[index].text =
                                      MedData["price_i"].toString();
                                  controllerPack[index].text =
                                      MedData["package"].toString();
                                  controllerphf[index].text =
                                      MedData["pharmacentical_form"].toString();
                                });
                              },
                            ),
                            width: TableDataHelper_p.kTableColumnsList[1].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Color(0XFF1e224c)),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                controller: controllerC[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[2].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Color(0XFF1e224c)),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                controller: controllerPack[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[3].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Color(0XFF1e224c)),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                controller: controllerphf[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[4].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Color(0XFF1e224c)),
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                onChanged: (x) {
                                  updateData1("number", x);
                                  print(x);

                                  controllerm[index].text = (int.parse(x) *
                                          int.parse(MedData["price_i"]))
                                      .toString();
                                  updateData1(
                                      "amount1",
                                      (int.parse(x) *
                                          int.parse(MedData["price_i"])));
                                  amountAll[index] =
                                      int.parse(controllerm[index].text);
                                  amountallA = amountAll[0] +
                                      amountAll[1] +
                                      amountAll[2] +
                                      amountAll[3] +
                                      amountAll[4] +
                                      amountAll[5] +
                                      amountAll[6] +
                                      amountAll[7] +
                                      amountAll[8] +
                                      amountAll[9];
                                  setState(() {
                                    _textSelected4.text = amountallA.toString();
                                  });
                                },
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[5].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Color(0XFF1e224c)),
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                onChanged: (x) {
                                  controllerH[index].text =
                                      ((int.parse(x) * MedData["price_i"]) /
                                              (int.parse(data2["number"])))
                                          .ceil()
                                          .toString();
                                  amountH[index] =
                                      int.parse(controllerH[index].text);
                                  print("الحسم" + controllerH[index].text);
                                  amountallH = amountH[0] +
                                      amountH[1] +
                                      amountH[2] +
                                      amountH[3] +
                                      amountH[4] +
                                      amountH[5] +
                                      amountH[6] +
                                      amountH[7] +
                                      amountH[8] +
                                      amountH[9];
                                  if (x.isNotEmpty) {
                                    updateData1(
                                        "price",
                                        (int.parse(controllerprice[index]
                                                    .text) -
                                                (int.parse(x) *
                                                        MedData["price_i"]) /
                                                    (int.parse(
                                                        data2["number"])))
                                            .ceil());
                                  } else {
                                    updateData1(
                                        "price", int.parse(MedData["price_i"]));
                                  }
                                },
                                controller: controllerHasem[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[6].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                style: TextStyle(color: Color(0XFF1e224c)),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                controller: controllerprice[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[7].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                style: TextStyle(color: Color(0XFF1e224c)),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                controller: controllerm[index],
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[8].width,
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white30),
                                ),
                              ),
                              child: TextFormField(
                                controller: _dateController[index],
                                readOnly: true,
                                style: TextStyle(
                                    color: Color(0XFF1e224c), fontSize: 15),
                                cursorColor: Color(0XFF1e224c),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      _dateController[index].text =
                                          selectedDate.year.toString() +
                                              "-" +
                                              selectedDate.month
                                                  .toString()
                                                  .padLeft(2, '0') +
                                              "-" +
                                              selectedDate.day
                                                  .toString()
                                                  .padLeft(2, '0');

                                      updateData1("expiry_date",
                                          _dateController[index].text);
                                      if (controllerHasem[index].text.isEmpty) {
                                        updateData1(
                                            "price", MedData["price_i"]);
                                      }
                                      print(
                                          "size = ${_dateController[index].text.length}");
                                      if (_dateController[index].text.length ==
                                          10) {
                                        addData(data2);
                                        print("data2 = ${data2}");
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                            width: TableDataHelper_p.kTableColumnsList[9].width,
                          ),
                        ),
                      ]);
                }),
              ),
            ),
          ), // end
        ],
      ),
    );
  }

  Widget tableHeader() {
    return Row(
      children: [
        // start
        DataTable(
          columnSpacing: 0,
          horizontalMargin: 0,
          columns: TableDataHelper_p.kTableColumnsList
              .getRange(TableDataHelper_p.kTableColumnsList.length - 1,
                  TableDataHelper_p.kTableColumnsList.length)
              .map((e) {
            return DataColumn(
              label: SizedBox(
                child: Text(e.title ?? '',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
                width: e.width ?? 0,
              ),
            );
          }).toList(),
          headingRowColor: MaterialStateProperty.all(Color(0xffe18505)),
          // dataRowColor: MaterialStateProperty.all(Colors.orange.shade100),
          rows: const [],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: headerScrollController,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: 0,
              headingRowColor: MaterialStateProperty.all(Color(0xffe18505)),
              // dataRowColor: MaterialStateProperty.all(Colors.blue.shade100),
              columns: TableDataHelper_p.kTableColumnsList
                  .getRange(1, TableDataHelper_p.kTableColumnsList.length - 1)
                  .map((e) {
                return DataColumn(
                  label: SizedBox(
                    child: Text(e.title ?? '',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                    width: e.width ?? 0,
                  ),
                );
              }).toList(),
              rows: const [],
            ),
          ),
        ),
        // end
      ],
    );
  }
}
