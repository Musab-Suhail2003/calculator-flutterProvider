import '../cal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZeroButton extends StatelessWidget {
  const ZeroButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Provider.of<CalculatorProvider>(context, listen: false).setValue("0"),
      child: Container(
        height: 70,
        width: 170,
        decoration: BoxDecoration(
            color: const Color.fromARGB(171, 51, 51, 51),
            borderRadius: BorderRadius.circular(40)),
        child:  Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "    0",
            style: TextStyle(
              fontSize: 38,
            ),
          ),
        )
      ),
    );
  }
}
