import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm1_mobile/main.dart';

import '../class/cardview.dart';
import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../model/new2.dart';
import '../table/screen_table_input_1.dart';

class botton extends StatefulWidget {
  const botton({Key? key}) : super(key: key);

  @override
  State<botton> createState() => _bottonState();
}

class _bottonState extends State<botton> {
  String? scannedValue;
  bool isTextFieldEmpty = false;
  List<String> data = [];
  TextEditingController textEditingController = TextEditingController();
  String selectedOption = "";

  bool isKeyboardVisible = false;

  get_post _req = get_post();
  selectAll() async {
    var response = await _req.postRequset(linkSelectAll, {
      "user_id": sharedPref.getString("id"),
    });
    return response;
  }

  select() async {
    var response = await _req.postRequset(linkSelect, {
      "user_id": sharedPref.getString("id"),
      "name": textEditingController.text,
    });
    return response;
  }

  Future<void> fetchData() async {
    var response = await _req.postRequset(linkSelectAllMed, {
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

  @override
  void initState() {
    fetchData();
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.15, // زيادة في الحجم
      child: FloatingActionButton(
        heroTag: "body",
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.search,
          size: 33,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => botton1(),
            ),
          );
          //showPopupMenu(context);
        },
      ),
    );
  }

  void showPopupMenu(BuildContext context) async {
    final selectedValue = await showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        String searchText = '';
        return AlertDialog(
          alignment: Alignment.center,
          title: Text('بحث عن المادة', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      controller:
                          textEditingController, // استخدام TextEditingController
                      style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                      cursorColor: Color(0XFF1e224c),
                      // cursorHeight: 23,
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
                              scannedValue = result as String?;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabled: true,
                        labelText: "اسم المادة",
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
                        textEditingController.text =
                            suggestion; // تحديث قيمة حقل النص
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                searchText.isNotEmpty
                    ? Container(
                        width: screenWidth,
                        height: (screenHeight / 2) - 90,
                        child: ListView(
                          children: [
                            FutureBuilder(
                                future: select(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data['status'] == 'isEmpty') {
                                      return Center(
                                        child: Text(
                                          "لايوجد مواد",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                        itemCount: snapshot.data['data'].length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return caredview(
                                              name:
                                                  "${snapshot.data['data'][i]['commercial_name_ar']}",
                                              pharmacentical_form:
                                                  "${snapshot.data['data'][i]['pharmacentical_form']}",
                                              caliber:
                                                  "${snapshot.data['data'][i]['caliber']}",
                                              package:
                                                  "${snapshot.data['data'][i]['package']}",
                                              price: snapshot.data['data'][i]
                                                  ['price_m'],
                                              ontap: () {},
                                              colorcard: Color(0XFF1e224c));
                                        });
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text("Loading..."),
                                    );
                                  }
                                  return Center(
                                    child: Text("Loading..."),
                                  );
                                })
                          ],
                        ))
                    : Container(
                        width: screenWidth,
                        height: (screenHeight / 2) - 90,
                        child: ListView(
                          children: [
                            FutureBuilder(
                                future: selectAll(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data['status'] == 'isEmpty') {
                                      return Center(
                                        child: Text(
                                          "لايوجد مواد",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                        itemCount: snapshot.data['data'].length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return caredview(
                                              name:
                                                  "${snapshot.data['data'][i]['commercial_name_ar']}",
                                              pharmacentical_form:
                                                  "${snapshot.data['data'][i]['pharmacentical_form']}",
                                              caliber:
                                                  "${snapshot.data['data'][i]['caliber']}",
                                              package:
                                                  "${snapshot.data['data'][i]['package']}",
                                              price: snapshot.data['data'][i]
                                                  ['price_m'],
                                              ontap: () {},
                                              colorcard: Color(0XFF1e224c));
                                        });
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text("Loading..."),
                                    );
                                  }
                                  return Center(
                                    child: Text("Loading..."),
                                  );
                                })
                          ],
                        )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "المشابهات",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                    width: screenWidth,
                    height: (screenHeight / 5) + 35,
                    child: ListView(
                      children: [
                        textEditingController.text.isEmpty
                            ? Container()
                            : FutureBuilder(
                                future: select(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data['status'] == 'isEmpty') {
                                      return Center(
                                        child: Text(
                                          "لايوجد مواد",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                        itemCount: snapshot.data['data'].length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return caredview(
                                              name:
                                                  "${snapshot.data['data'][i]['commercial_name_ar']}",
                                              pharmacentical_form:
                                                  "${snapshot.data['data'][i]['pharmacentical_form']}",
                                              caliber:
                                                  "${snapshot.data['data'][i]['caliber']}",
                                              package:
                                                  "${snapshot.data['data'][i]['package']}",
                                              price: snapshot.data['data'][i]
                                                  ['price_m'],
                                              ontap: () {},
                                              colorcard: Color(0XFF1e224c));
                                        });
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text("Loading..."),
                                    );
                                  }
                                  return Center(
                                    child: Text("Loading..."),
                                  );
                                })
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );

    if (selectedValue != null) {
      setState(() {
        selectedOption = selectedValue;
        textEditingController.text = selectedValue;
      });
    }
  }
}
