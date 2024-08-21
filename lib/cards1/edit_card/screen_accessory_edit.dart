import 'package:flutter/material.dart';
import 'package:pharm1_mobile/cards1/edit_card/screen_accessory_edit_card.dart';

import '../../class/cardview.dart';
import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../main.dart';

class acc_edit extends StatefulWidget {
  const acc_edit({Key? key}) : super(key: key);

  @override
  State<acc_edit> createState() => _acc_editState();
}

class _acc_editState extends State<acc_edit> {
  String searchText = "";
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  @override
  get_post _req = get_post();
  selectAll() async {
    var response = await _req.postRequset(linkSelectAllE, {
      "user_id": sharedPref.getString("id"),
    });
    return response;
  }

  select() async {
    var response = await _req.postRequset(linkSelectE, {
      "user_id": sharedPref.getString("id"),
      "name": textEditingController.text,
    });
    return response;
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('تعديل اكسسوار'),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
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
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  labelText: 'ادخل اسم الاكسسوار',
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
            ),
            SingleChildScrollView(
              child: Container(
                width: screenWidth - 20,
                height: screenHeight - 50,
                child: searchText.isEmpty
                    ? FutureBuilder(
                        future: selectAll(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  acc_edit_card(
                                                    edit: snapshot.data['data']
                                                        [i],
                                                  )),
                                        );
                                      });
                                    },
                                    colorcard: Colors.orange.shade400,
                                  );
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
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                        MaterialPageRoute(
                                            builder: (context) => acc_edit_card(
                                                  edit: snapshot.data['data']
                                                      [i],
                                                ));
                                      });
                                    },
                                    colorcard: Colors.orange.shade400,
                                  );
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
          ]),
        ),
      ),
    );
  }
}
