import 'package:flutter/material.dart';

class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "متابعة الأذكار بطريقة بسيطة",
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 38),
        )
      ],
    );
  }
}
