import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:pharm1_mobile/reports/med_inventory/screen_table_hedar_med_inventory.dart';

import '../../class/screen_class_addition.dart';
import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../main.dart';

class table_med_inven extends StatefulWidget {
  final String selectedDate;
  final String selectedDate1;
  final String num1;
  final String num2;
  final String name;
  final int type;
  table_med_inven(
      {required this.selectedDate,
      required this.selectedDate1,
      required this.num1,
      required this.num2,
      required this.name,
      required this.type});

  @override
  State<table_med_inven> createState() => _table_med_invenState();
}

// DataTable
// ScrollController
// Row
// Column

class _table_med_invenState extends State<table_med_inven> {
  // ScrollGroupController,
  // To Scroll the multiple scroll-view in sync using controller
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();

  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  get_post _req = get_post();
  linkMat() async {
    if (widget.type == 1) {
      var response = await _req.postRequset(linkMatAllEQ, {
        "date1": widget.selectedDate,
        "date2": widget.selectedDate1,
        "num1": widget.num1,
        "num2": widget.num2,
        "user_id": sharedPref.getString("id"),
      });
      print(response);
      return response;
    } else if (widget.type == 2) {
      var response = await _req.postRequset(linkMatOneEQ, {
        "date1": widget.selectedDate,
        "date2": widget.selectedDate1,
        "num1": widget.num1,
        "num2": widget.num2,
        "name": widget.name,
        "user_id": sharedPref.getString("id"),
      });
      print(response);
      return response;
    } else if (widget.type == 3) {
      var response = await _req.postRequset(linkMatAllE, {
        "date1": widget.selectedDate,
        "date2": widget.selectedDate1,
        "user_id": sharedPref.getString("id"),
      });
      print(widget.selectedDate);
      print(widget.selectedDate1);
      print(response);
      return response;
    } else if (widget.type == 4) {
      var response = await _req.postRequset(linkMatOneE, {
        "date1": widget.selectedDate,
        "date2": widget.selectedDate1,
        "name": widget.name,
        "user_id": sharedPref.getString("id"),
      });
      print(response);
      return response;
    } else if (widget.type == 5) {
      var response = await _req.postRequset(linkMatAllQ, {
        "num1": widget.num1,
        "num2": widget.num2,
        "user_id": sharedPref.getString("id"),
      });
      print(response);
      return response;
    } else if (widget.type == 6) {
      var response = await _req.postRequset(linkMatOneQ, {
        "num1": widget.num1,
        "num2": widget.num2,
        "name": widget.name,
        "user_id": sharedPref.getString("id"),
      });
      print(response);
      return response;
    }
  }

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: name_date(
            date: 'من : ${widget.selectedDate} الى : ${widget.selectedDate1} ',
            text: "تقرير جرد مواد"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            tableContent(),
            tableHeader(),
          ],
        ),
      ),
    );
  }

  Widget tableContent() {
    return SingleChildScrollView(
      child: Row(
        children: [
          // start

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: dataScrollController,
              child: FutureBuilder(
                  future: linkMat(),
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
                      return DataTable(
                        horizontalMargin: 0,
                        columnSpacing: 0,
                        //headingRowColor: MaterialStateProperty.all(Colors.green),
                        //dataRowColor: MaterialStateProperty.all(Colors.blue.shade100),
                        columns: TableDataHelper_med_inven.kTableColumnsList
                            .map((e) {
                          return DataColumn(
                            label: SizedBox(
                              child: Text(e.title ?? ''),
                              width: e.width ?? 0,
                            ),
                          );
                        }).toList(),
                        rows: List.generate(snapshot.data['data'].length,
                            (index) {
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
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right:
                                              BorderSide(color: Colors.white30),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        snapshot.data['data'][index]
                                                ['expriy_date']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_med_inven
                                        .kTableColumnsList[0].width,
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right:
                                              BorderSide(color: Colors.white30),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        snapshot.data['data'][index]['ma_id']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_med_inven
                                        .kTableColumnsList[1].width,
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right:
                                              BorderSide(color: Colors.white30),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        snapshot.data['data'][index]['number']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_med_inven
                                        .kTableColumnsList[2].width,
                                  ),
                                ),
                              ]);
                        }),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
                      );
                    }
                    return Center(
                      child: Text("Loading..."),
                    );
                  }),
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

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: headerScrollController,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: 0,
              headingRowColor: MaterialStateProperty.all(Color(0xffe18505)),
              // dataRowColor: MaterialStateProperty.all(Colors.blue.shade100),
              columns: TableDataHelper_med_inven.kTableColumnsList.map((e) {
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
