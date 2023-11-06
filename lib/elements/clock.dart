import 'dart:async';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:khushoo/state_manger/brain.dart';
import 'package:flutter/material.dart';
import 'package:khushoo/elements/notification.dart';
import 'package:khushoo/elements/constans.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
  String time = DateFormat("HH:mm").format(DateTime.now());
  int seconds = DateTime.now().second;
  String previos = '--';
  String next = '--';
  bool notified = false;
  late int minuts;
  late int hours;

  double proccess = 1;
  late Map times;
  late int diff = 0;
  late int nextTimer;
  late int prevTimer;
  late var preyerTimes = {};

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setListOfTimes();

      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds = DateTime.now().second;
          minuts = DateTime.now().minute;
          hours = DateTime.now().hour;
          time = DateFormat("HH:mm")
              .format(DateTime.now()); // time is not changing please check!!
        });

        getPreviousAndNext();

        // add(); // this will move the semicircule indecator

        nextTimer =
            (int.parse(preyerTimes[next].toString().split(":")[0]) * 60 +
                int.parse(preyerTimes[next].toString().split(":")[1]));

        prevTimer =
            (int.parse(preyerTimes[previos].toString().split(":")[0]) * 60 +
                int.parse(preyerTimes[previos].toString().split(":")[1]));

        diff = previos == "Isha" &&
                1439 <= (hours * 60 + minuts) &&
                (hours * 60 + minuts) <= nextTimer
            ? nextTimer + (1439 - (hours * 60 + minuts))
            : nextTimer - (hours * 60 + minuts);

        print(mapToZeroOne((hours * 60 + minuts), prevTimer, nextTimer));
        print(nextTimer);
        print(prevTimer);
        print((hours * 60 + minuts));

        // print(mapToZeroOne(1000, 1000, 1400));
      });
    }
    // setProccess();
  }

  // void setProccess() {
  //   remap((hours * 60 + minuts), prevTimer, nextTimer);
  // }

  double mapToZeroOne(int value, int minRange, int maxRange) {
    if (minRange == maxRange) {
      // Avoid division by zero when the range is degenerate.
      return 0.0;
    }

    // Calculate the proportion of the value within the range.
    double proportion = (value - minRange) / (maxRange - minRange).toDouble();

    // Ensure that the result is within the [0, 1] range.
    proportion = proportion.clamp(0.0, 1.0);

    return proportion;
  }

  void callNotife() {
    notification().sendNotification("Prey Time");
    notified = true;
  }

  void add() {
    proccess >= 1
        ? setState(() {
            proccess = 0;
          })
        : setState(() {
            // hours - 1 + 60 / minuts
            proccess += (0.01 / 60);
          });
  }

  String changeToArabic(String label) {
    switch (label) {
      case "Fajr":
        {
          return "الفجر";
        }
      case "Dhuhr":
        {
          return "الظهر";
        }
      case "Asr":
        {
          return "العصر";
        }
      case "Maghrib":
        {
          return "المغرب";
        }
      case "Isha":
        {
          return "العشاء";
        }
      default:
        {
          return "";
        }
    }
  }

  @override
  void dispose() {
    // add();
    Timer;
    super.dispose();
  }

  void getPreviousAndNext() {
    Iterable<MapEntry> entries = preyerTimes.entries;
    for (final Entry in entries) {
      if ((hours * 60 + minuts) <=
          (int.parse(Entry.value.toString().split(":")[0]) * 60 +
              int.parse(Entry.value.toString().split(":")[1]))) {
        if (Entry.key == ("Fajr")) {
          next = Entry.key;
          previos = "Isha";
          break;
        }
        next = Entry.key;
        break;
      }
      previos = Entry.key;
    }
    previos == "Isha" ? next = "Fajr" : null;
  }

  void setListOfTimes() {
    var value = context.read<Brain>().getJson()['data']['timings'];
    setState(() {
      for (var key in value.entries) {
        ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].contains(key.key)
            ? preyerTimes[key.key] = key.value
            : preyerTimes;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(builder: (context, value, child) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: FractionalOffset.fromOffsetAndSize(
                  const Offset(10, 60), const Size(20, 40)),
              children: [
                SemicircularIndicator(
                  bottomPadding: 0.0,
                  color: kButtonColor,
                  contain: false,
                  progress: proccess,
                  backgroundColor: kElementsColor,
                  radius: 150,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.location,
                          style: TextStyle(
                              color: kTextColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                seconds <= 9 ? "0$seconds" : seconds.toString(),
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: kButtonColor,
                  child: SizedBox(
                    height: 35,
                    width: 60,
                    child: Center(
                      child: Text(
                        context.watch<Brain>().arabic
                            ? changeToArabic(next)
                            : previos,
                        style: TextStyle(color: kTextColor),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    context.watch<Brain>().arabic
                        ? "الباقي لصلاة ${changeToArabic(next)} : ${diff % 60 < 10 ? "0${diff % 60}" : diff % 60} : ${(diff / 60).floor()}"
                        : "Time till $next: ${(diff / 60).floor()} : ${diff % 60 < 10 ? "0${diff % 60}" : diff % 60}",
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                    textHeightBehavior: TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even),
                  ),
                ),
                Card(
                  color: kButtonColor,
                  child: SizedBox(
                    height: 35,
                    width: 60,
                    child: Center(
                      child: Text(
                        context.watch<Brain>().arabic
                            ? changeToArabic(previos)
                            : next,
                        style: TextStyle(color: kTextColor),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
