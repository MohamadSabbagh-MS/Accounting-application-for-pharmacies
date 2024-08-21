import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:pharm1_mobile/reports/debts/screen_table_hedar_debts.dart';

import '../../class/screen_class_addition.dart';
import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../main.dart';

class table_debts extends StatefulWidget {
  final String selectedDate;
  final String selectedDate1;
  final int ch;
  final String name;
  table_debts(
      {required this.selectedDate,
      required this.selectedDate1,
      required this.ch,
      required this.name});

  @override
  State<table_debts> createState() => _table_debtsState();
}

// DataTable
// ScrollController
// Row
// Column

class _table_debtsState extends State<table_debts> {
  // ScrollGroupController,
  // To Scroll the multiple scroll-view in sync using controller
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();

  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  get_post _req = get_post();
  linkDebt() async {
    var response = await _req.postRequset(linkDebtD, {
      "date1": widget.selectedDate,
      "date2": widget.selectedDate1,
      "check": widget.ch,
      "cus": widget.name,
      "user_id": sharedPref.getString("id"),
    });
    return response;
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
            text: "تقرير دائن/مدين"),
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
                  future: linkDebt(),
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
                        columns:
                            TableDataHelper_debts.kTableColumnsList.map((e) {
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
                                        snapshot.data['data'][index]['date']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_debts
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
                                        snapshot.data['data'][index]['cus_id']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_debts
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
                                        snapshot.data['data'][index]
                                                ['total_amount_status_1']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_debts
                                        .kTableColumnsList[2].width,
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
                                        snapshot.data['data'][index]
                                                ['total_amount_status_2']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                    width: TableDataHelper_debts
                                        .kTableColumnsList[3].width,
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
              columns: TableDataHelper_debts.kTableColumnsList.map((e) {
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
