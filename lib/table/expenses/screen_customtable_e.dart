import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:pharm1_mobile/table/expenses/screen_table_data_helper_e.dart';

class CustomTable_e extends StatefulWidget {
  const CustomTable_e({Key? key}) : super(key: key);

  @override
  State<CustomTable_e> createState() => _CustomTable_eState();
}

// DataTable
// ScrollController
// Row
// Column

class _CustomTable_eState extends State<CustomTable_e> {
  // ScrollGroupController,
  // To Scroll the multiple scroll-view in sync using controller
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();

  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          DataTable(
            columnSpacing: 0,
            horizontalMargin: 0,
            columns: TableDataHelper_e.kTableColumnsList
                .getRange(TableDataHelper_e.kTableColumnsList.length - 1,
                    TableDataHelper_e.kTableColumnsList.length)
                .map((e) {
              return DataColumn(
                label: SizedBox(
                  child: Text(e.title ?? '', textAlign: TextAlign.center),
                  width: e.width ?? 0,
                ),
              );
            }).toList(),
            // headingRowColor: MaterialStateProperty.all(Colors.orange),
            dataRowColor: MaterialStateProperty.all(Color(0xffffdd95)),
            rows: List.generate(10, (index) {
              return DataRow(cells: [
                DataCell(
                  SizedBox(
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                    ),
                    width: TableDataHelper_e.kTableColumnsList.last.width,
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
                columns: TableDataHelper_e.kTableColumnsList
                    .getRange(1, TableDataHelper_e.kTableColumnsList.length - 1)
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
                              ),
                            ),
                            width: TableDataHelper_e.kTableColumnsList[2].width,
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
                              ),
                            ),
                            width: TableDataHelper_e.kTableColumnsList[2].width,
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
          columns: TableDataHelper_e.kTableColumnsList
              .getRange(TableDataHelper_e.kTableColumnsList.length - 1,
                  TableDataHelper_e.kTableColumnsList.length)
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
              columns: TableDataHelper_e.kTableColumnsList
                  .getRange(1, TableDataHelper_e.kTableColumnsList.length - 1)
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
