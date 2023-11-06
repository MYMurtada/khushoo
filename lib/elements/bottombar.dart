import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:khushoo/elements/constans.dart';
import 'package:khushoo/state_manger/brain.dart';
import 'package:provider/provider.dart';

class BottomBarAnimated extends StatelessWidget {
  const BottomBarAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(
      builder: (BuildContext context, value, Widget? child) {
        return CurvedNavigationBar(
            index: 1,
            backgroundColor:
                value.index == 1 ? kElementsColor : kBackgroundColor, //  for the main page having a diffrent color.
            color: kButtonColor,
            animationDuration: const Duration(milliseconds: 400),
            items: const <Widget>[
              Icon(CupertinoIcons.book_circle_fill,
                  color: Colors.white, size: 30),
              Icon(Icons.home, color: Colors.white, size: 30),
              Icon(Icons.settings, color: Colors.white, size: 30),
            ],
            onTap: (index) {
              //Handle button tap
              value.setIndex(index);
            });
      },
    );
  }
}
