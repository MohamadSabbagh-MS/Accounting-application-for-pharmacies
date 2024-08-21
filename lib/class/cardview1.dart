import 'package:flutter/material.dart';

class caredview1 extends StatelessWidget {
  final void Function()? ontap;
  final String name;
  final String pharmacentical_form;
  final String caliber;
  final String package;
  final int price;
  final Color colorcard;
  final String number;

  const caredview1({
    Key? key,
    required this.ontap,
    required this.name,
    required this.pharmacentical_form,
    required this.caliber,
    required this.package,
    required this.price,
    required this.colorcard,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
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
                    "السعر : $price  ",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
