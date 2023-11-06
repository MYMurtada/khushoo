import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:khushoo/elements/adkar_card.dart';
import 'package:khushoo/elements/constans.dart';
import 'package:khushoo/elements/pray_card.dart';
import 'package:flutter/material.dart';
import 'package:khushoo/pages/control_page.dart';
import 'page1.dart';
import 'page2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final _controller = PageController(initialPage: 0);
bool isClicked = true;
bool lastScreen = false;
bool firstScreen = true;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(children: [
                    Center(
                      child: AnimatedCrossFade(
                        layoutBuilder: (topChild, topChildKey, bottomChild,
                                bottomChildKey) =>
                            Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              key: bottomChildKey,
                              child: bottomChild,
                            ),
                            Positioned(
                              key: topChildKey,
                              child: topChild,
                            ),
                          ],
                        ),
                        firstChild: ListView(children: const [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              prayCard(
                                  label: 'الفجر',
                                  icon: CupertinoIcons.sunrise_fill,
                                  time: '5:30'),
                              prayCard(
                                  label: 'الظهر',
                                  icon: Icons.sunny,
                                  time: '12:30'),
                              prayCard(
                                  label: 'العصر',
                                  icon: Icons.wb_twilight_rounded,
                                  time: '4:00'),
                              prayCard(
                                  label: 'المغرب',
                                  icon: CupertinoIcons.sunset_fill,
                                  time: '6:37'),
                            ],
                          ),
                        ]),
                        secondChild: PageView(
                          scrollDirection:
                              axisDirectionToAxis(AxisDirection.down),
                          children: [
                            AdkarCard(
                              label: 'أذكار الصباح',
                              adkars: {"لا اله الا الله": 2},
                            )
                          ],
                        ),
                        duration: const Duration(milliseconds: 500),
                        crossFadeState: !firstScreen
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: kFadeColor,
                              stops: [0, 1])),
                      alignment: Alignment.center,
                    ),
                  ]),
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        lastScreen = index == 1;
                        firstScreen = index == 0;
                      });
                    },
                    controller: _controller,
                    children: const [page2(), page1()],
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: !lastScreen
                              ? () {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.fastEaseInToSlowEaseOut);
                                }
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ControlPage()));
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kButtonColor,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(5),
                            height: 50,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                !lastScreen ? 'التالي' : 'تم',
                                style: TextStyle(
                                  color: kLightElementColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
