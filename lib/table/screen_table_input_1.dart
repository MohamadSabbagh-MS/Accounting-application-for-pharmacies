import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pharm1_mobile/class/cardview.dart';
import 'package:pharm1_mobile/connect_db/Links.dart';
import 'package:pharm1_mobile/connect_db/get_post.dart';
import 'package:pharm1_mobile/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class table_input extends StatefulWidget {
  final void Function(String x)? ontap;

  table_input({
    this.ontap,
  });
  @override
  _table_inputState createState() => _table_inputState();
}

class _table_inputState extends State<table_input> {
  String? scannedValue;
  bool isTextFieldEmpty = false;
  List<String> data = [];
  TextEditingController textEditingController = TextEditingController();
  String selectedOption = "";

  bool isKeyboardVisible = false;

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

  onttap(x) {
    widget.ontap!(x);
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
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white30),
        ),
      ),
      child: TextFormField(
        controller: textEditingController,
        onTap: () {
          showPopupMenu(context);
          setState(() {});
        },
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 10),
        ),
      ),
    );
  }

  void showPopupMenu(BuildContext context) async {
    final selectedValue = await showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          alignment: Alignment.center,
          title: Text('بحث عن المادة', textAlign: TextAlign.center),
          content: Container(
            width: screenWidth,
            height: (screenHeight - 10),
            child: Search(
              onChanged: (value) {
                setState(() {
                  textEditingController.text =
                      value; // تحديث القيمة دون إغلاق الـ popup menu
                });
              },
              ontap: onttap,
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

class Search extends StatefulWidget {
  final void Function(String x)? ontap;
  final Function(String) onChanged;

  Search({
    this.ontap,
    required this.onChanged,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? scannedValue;
  bool isTextFieldEmpty = false;
  List<String> data = [];
  TextEditingController textEditingController = TextEditingController();
  String selectedOption = "";

  bool isKeyboardVisible = false;

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

  onttap(x) {
    widget.ontap!(x);
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
                widget.onChanged(searchText);
              });
              widget.ontap!(value);
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
          Container(
            height: (screenHeight / 3) - 30,
            width: screenWidth,
            child: ListView(
              children: [
                searchText.isEmpty
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
                                      price: int.parse(
                                          snapshot.data['data'][i]['price_m']),
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
                                      price: int.parse(
                                          snapshot.data['data'][i]['price_m']),
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("المشابهات"),
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool onpress = false;
  String? scannedvalue;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FloatingActionButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.orange,
                ),
              ),
              backgroundColor:
                  onpress == false ? Colors.transparent : Colors.orange,
              child: Icon(Icons.flash_on_outlined),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {
                  if (onpress == false) {
                    onpress = true;
                  } else {
                    onpress = false;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        scannedvalue = scanData.code;
      });
      if (scannedvalue != null) {
        controller.pauseCamera();
        Navigator.pop(context, scannedvalue);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
