import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String label;
  final Function() onTap;
  Buttons({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        width: 115,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF4e5ae8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
