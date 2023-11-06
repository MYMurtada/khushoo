import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khushoo/elements/bottombar.dart';
import 'package:khushoo/elements/constans.dart';
import 'package:khushoo/pages/adkar_page.dart';
import 'package:khushoo/pages/setting_page.dart';
import 'package:khushoo/state_manger/brain.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:khushoo/pages/main_page.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  List<Widget> screens = [const AdkarPage(), const MainPage(), SettingPage()];
  bool appear = false;
  int seconds = 0;
  @override
  void initState() {
    super.initState();
    context.read<Brain>().waitForPrep(context);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 10) {
        setState(() {
          appear = true;
        });
      }
      seconds++;
    });
  }

  Widget selected() {
    return context.watch<Brain>().done
        ? SafeArea(
            child: Consumer(
              builder: (BuildContext context, value, Widget? child) {
                return Scaffold(
                    bottomNavigationBar: const BottomBarAnimated(),
                    backgroundColor: kBackgroundColor,
                    body: screens[context.watch<Brain>().index]);
              },
            ),
          )
        : Center(
            child: appear
                ? AlertDialog(
                    content: Text("Please check your network connection!"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            appear = false;
                            seconds = 0;
                            selected();
                          },
                          child: Text("Try Again"))
                    ],
                  )
                : Container(
                    child: LoadingOverlay(
                    isLoading: true,
                    color: Colors.black,
                    child: Container(
                      child: context.read<Brain>().networkStatus != null
                          ? const Text(
                              "Please check your network!",
                              style: TextStyle(color: Colors.white),
                            )
                          : null,
                    ),
                  )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kBackgroundColor, body: selected());
  }
}
