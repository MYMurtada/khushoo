import 'package:flutter/material.dart';
import 'package:khushoo/elements/constans.dart';

class SettingButton extends StatelessWidget {
  final String label;
  final Icon icon;

  const SettingButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: (MediaQuery.of(context).size.height / 4) - 8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              offset: Offset(4, 4),
              spreadRadius: 1,
              color: kElementsColor),
          BoxShadow(
              blurRadius: 15,
              offset: Offset(-4, -4),
              spreadRadius: 1,
              color: Colors.black),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: kButtonColor,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon,
        Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        )
      ]),
    );
  }
}
