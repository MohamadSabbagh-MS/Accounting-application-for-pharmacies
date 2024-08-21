import 'package:flutter/material.dart';

import '../class/cardview.dart';
import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';
import '../main.dart';
import '../table/screen_table_input_1.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String searchText = "";
  List<String> searchResults = ["Result 1", "Result 2", "Result 3"];
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

  selectMosh() async {
    var response = await _req.postRequset(linkSelectMo, {
      "user_id": sharedPref.getString("id"),
      "name": textEditingController.text,
    });
    return response;
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
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
                    MaterialPageRoute(builder: (context) => QRViewExample()),
                  );
                  setState(() {
                    textEditingController.text = result as String? ?? '';
                  });
                },
              ),
              filled: true,
              fillColor: Colors.white,
              enabled: true,
              labelText: 'ادخل اسم المادة',
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
          SingleChildScrollView(
            child: Container(
              height: (screenHeight / 3) - 30,
              width: screenWidth,
              child: searchText.isEmpty
                  ? FutureBuilder(
                      future: selectAll(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'isEmpty') {
                            return Center(
                              child: Text(
                                "لايوجد مواد",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    price: snapshot.data['data'][i]['price_m'],
                                    ontap: () {
                                      setState(() {
                                        textEditingController.text =
                                            "${snapshot.data['data'][i]['commercial_name_ar']}";
                                      });
                                    },
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
                  : FutureBuilder(
                      future: select(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'isEmpty') {
                            return Center(
                              child: Text(
                                "لايوجد مواد",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    price: snapshot.data['data'][i]['price_m'],
                                    ontap: () {
                                      setState(() {
                                        textEditingController.text =
                                            "${snapshot.data['data'][i]['commercial_name_ar']}";
                                      });
                                    },
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
                      }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: (screenHeight / 3) - 20,
              width: screenWidth,
              child: ListView(
                children: [
                  textEditingController.text.isEmpty
                      ? Container()
                      : FutureBuilder(
                          future: selectMosh(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data['status'] == 'isEmpty') {
                                return Center(
                                  child: Text(
                                    "لايوجد مواد",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                        ontap: () {
                                          setState(() {
                                            textEditingController.text =
                                                "${snapshot.data['data'][i]['commercial_name_ar']}";
                                          });
                                        },
                                        colorcard: Colors.orange.shade400);
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
    );
  }
}
