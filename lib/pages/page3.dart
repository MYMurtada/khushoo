import 'package:flutter/material.dart';

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "تنبيهات لاوقات الصلوات",
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 38),
        )
      ],
    );
  }
}
