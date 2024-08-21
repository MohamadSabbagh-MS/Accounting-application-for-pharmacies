import 'package:flutter/material.dart';

class caredview extends StatelessWidget {
  final void Function()? ontap;
  final String name;
  final String pharmacentical_form;
  final String caliber;
  final String package;
  final int price;
  final Color colorcard;

  const caredview({
    Key? key,
    required this.ontap,
    required this.name,
    required this.pharmacentical_form,
    required this.caliber,
    required this.package,
    required this.price,
    required this.colorcard,
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
