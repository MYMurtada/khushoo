import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:khushoo/elements/clock.dart';
import 'package:khushoo/elements/constans.dart';
import 'package:khushoo/elements/pray_card.dart';
import 'package:flutter/material.dart';
import 'package:khushoo/state_manger/brain.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(
      builder: (BuildContext context, value, Widget? child) {
        dynamic values = value.getJson()['data']['timings'];

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  width: 350,
                  height: 230,
                  child: const Clock(),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration:  BoxDecoration(
                  color: kElementsColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    prayCard(
                      icon: CupertinoIcons.sunrise_fill,
                      label: value.arabic ? "الفجر" : 'Fajr',
                      time: values['Fajr'].toString(),
                    ),
                    prayCard(
                      icon: Icons.sunny,
                      label: value.arabic ? "الظهر" : 'Dhuhr',
                      time: values['Dhuhr'].toString(),
                    ),
                    prayCard(
                      icon: Icons.wb_twilight_rounded,
                      label: value.arabic ? "العصر" : 'Asr',
                      time: values['Asr'].toString(),
                    ),
                    prayCard(
                      icon: CupertinoIcons.sunset_fill,
                      label: value.arabic ? "المغرب" : 'Magreb',
                      time: values['Maghrib'].toString(),
                    ),
                    prayCard(
                      icon: Icons.nights_stay,
                      label: value.arabic ? "العشاء" : 'Isha',
                      time: values['Isha'].toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
