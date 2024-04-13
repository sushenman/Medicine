import 'package:flutter/material.dart';

class MyInputTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final Widget? customwi;

  const MyInputTextField({
    Key? key,
    required this.label,
     this.controller,
 
    this.customwi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(

        readOnly: customwi == null ? false : true,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: customwi ,
          contentPadding: EdgeInsets.only(left: 10),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
