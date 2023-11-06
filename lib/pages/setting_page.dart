import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khushoo/elements/constans.dart';
import 'package:khushoo/elements/setting_button.dart';
import 'package:khushoo/state_manger/brain.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(
        builder: (BuildContext context, value, Widget? child) {
      return SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: (MediaQuery.of(context).size.height / 4) - 8,
                child: TextButton(
                  style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: null,
                      backgroundColor: null),
                  onPressed: () {
                    value.waitForPrep(context);
                    value.switchLanguage();
                    print("Button is clicked");
                  },
                  child: SettingButton(
                    icon: const Icon(
                      Icons.language_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                    label: value.arabic ? "تغير اللغة" : "Change the language",
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: (MediaQuery.of(context).size.height / 4) - 8,
                child: TextButton(
                  style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: null,
                      backgroundColor: null),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: value.arabic
                          ? Text(
                              "قريبا",
                              textAlign: TextAlign.end,
                            )
                          : Text("Coming soon"),
                      content: value.arabic
                          ? Text(
                              "سيتم اضافة الميزة قريبا",
                              textAlign: TextAlign.end,
                            )
                          : Text('This feature will be added soon'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                  child: SettingButton(
                    icon: const Icon(
                      Icons.color_lens,
                      size: 100,
                      color: Colors.white,
                    ),
                    label: value.arabic ? "تغير الخلفية" : "Change the theme",
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              value.arabic
                  ? ": المطور\n@SWE_Mohammad\nالإصدار 0.0.1"
                  : "Devolped by :\n@SWE_Mohammad\nVersion 0.0.1",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ));
    });
  }
}
