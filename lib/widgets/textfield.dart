import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: TextField(
        
        textAlign: TextAlign.end,
        controller: controller,
        decoration: const InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.black,
            filled: true),
        style: const TextStyle(fontSize: 50),
        readOnly: true,
        autofocus: true,
        showCursor: true,
      ),
    );
  }
}
