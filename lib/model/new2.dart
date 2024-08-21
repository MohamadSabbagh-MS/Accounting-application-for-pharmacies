import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pharm1_mobile/main.dart';
import 'package:pharm1_mobile/model/new.dart';

import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';

class botton1 extends StatefulWidget {
  const botton1({Key? key}) : super(key: key);

  @override
  State<botton1> createState() => _botton1State();
}

class _botton1State extends State<botton1> {
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
          showPopupMenu(context);
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
          content: Container(
            width: screenWidth,
            height: (screenHeight - 10),
            child: MyHomePage1(),
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
