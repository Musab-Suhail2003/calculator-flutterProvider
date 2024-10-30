import '../cal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Button1 extends StatelessWidget {
  const Button1(
      {super.key,
       required this.label,
        this.color = const Color.fromARGB(171, 51, 51, 51),
        this.textcolor = Colors.white});

  final String label;
  final Color color;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<CalculatorProvider>(context, listen: false)
          .setValue(label),
      child: Material(
        elevation: 3,
        color: color,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 38,
          backgroundColor: color,
          child: Text(
            label,
            style: TextStyle(
                color: textcolor, fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
