import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController dateController;
  final String labelText;
  DatePickerField({required this.dateController, required this.labelText});

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
      cursorColor: Color(0XFF1e224c),
      cursorHeight: 23,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabled: true,
        labelText: widget.labelText,
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
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ).then((selectedDate) {
          if (selectedDate != null) {
            String year = selectedDate.year.toString();
            String month = selectedDate.month.toString();
            String day = selectedDate.day.toString();

            widget.dateController.text = year + '-' + month + '-' + day;
          }
        });
      },
    );
  }
}

Widget tff_add_items({
  required String labelText,
  required TextEditingController Controls,
  required TextInputType type,
}) =>
    TextFormField(
      keyboardType: type,
      controller: Controls,
      style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
      cursorColor: Color(0XFF1e224c),
      cursorHeight: 23,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabled: true,
        labelText: labelText,
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
    );

Widget eb_add_items({
  required String text,
}) =>
    Container(
      width: 130,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xffe18505),
          ),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
Widget medcard({
  required String name,
  required String caliber,
  required String pharmacentical_form,
  required String package,
  required String number,
  required String date,
  required Color colorcard,
  required String price,
}) =>
    InkWell(
      onTap: () {
        print('l,,o,o');
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colorcard,
          ),
          child: Column(
            children: [
              Text(
                "$name - $pharmacentical_form - $caliber - $package",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "العدد : $number",
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "السعر : $price",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text(
                "الإنتهاء : $date",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

Widget name_date({
  required String text,
  required String date,
}) =>
    Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          text,
        ),
        Text(
          date,
          style: TextStyle(fontSize: 13),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
