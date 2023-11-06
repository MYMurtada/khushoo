import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constans.dart';
import 'package:khushoo/elements/notification.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';

class AdkarCard extends StatefulWidget {
  final String label;
  final Map adkars;
  int currentIndex = 0;
  int counter = 0;

  AdkarCard({required this.label, required this.adkars});

  @override
  State<AdkarCard> createState() => _AdkarCardState();
}

class _AdkarCardState extends State<AdkarCard> {
  var clicked = true;
  double prog = 0.0;
  late int clickCounter = widget.adkars.values.elementAt(widget.currentIndex);

  @override
  void initState() {
    notification().setUp();
    super.initState();
  }

  Future<void> click() async {
    setState(() {
      clicked = !clicked;
    });
  }

  void getNext() {
    widget.currentIndex < widget.adkars.length - 1
        ? widget.currentIndex++
        : widget.currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kElementsColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          ListTile(
            leading: Text("      "),
            title: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kTextColor, fontSize: 20, fontWeight: FontWeight.w700),
            ),
            trailing: Text(
              "${widget.currentIndex + 1} / ${widget.adkars.length}",
              style: TextStyle(color: kTextColor, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                  // height: MediaQuery.of(context).size.height - 400,
                  // width: MediaQuery.of(context).size.width - 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4),
                        color: Colors.black54,
                      ),
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(-4, -4),
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                      Center(
                        child: Text(
                          widget.adkars.keys.elementAt(widget.currentIndex),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kBackgroundColor,
                              fontWeight: FontWeight.w900,
                              fontSize: MediaQuery.of(context).size.width / 25),
                        ),
                      ),
                    ]),
                  )),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Stack(
                  children: [
                    widget.currentIndex != 0
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.currentIndex--;
                                  clickCounter = widget.adkars.values
                                      .elementAt(widget.currentIndex);
                                  prog = 0;
                                });
                              },
                              style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                              child: Icon(
                                CupertinoIcons.arrow_left_circle,
                                color: kButtonColor,
                              ),
                            ),
                          )
                        : Container(),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SemicircularIndicator(
                            strokeCap: StrokeCap.round,
                            color: kButtonColor,
                            backgroundColor: kBackgroundColor,
                            radius: 100,
                            contain: true,
                            progress: prog,
                            child: GestureDetector(
                              onTap: () {
                                click().then((value) => Future.delayed(
                                        const Duration(milliseconds: 100))
                                    .then((value) => click()));

                                setState(() {
                                  if (prog >= 0.99) {
                                    getNext();
                                    prog = 0;
                                    clickCounter = widget.adkars.values
                                        .elementAt(widget.currentIndex);
                                  } else {
                                    clickCounter--;
                                    prog += 1 /
                                        widget.adkars.values
                                            .elementAt(widget.currentIndex);
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 70),
                                  decoration: BoxDecoration(
                                      boxShadow: clicked
                                          ? [
                                              const BoxShadow(
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                                offset: Offset(4, 4),
                                                color: Colors.white,
                                              ),
                                              const BoxShadow(
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                                offset: Offset(-4, -4),
                                                color: Colors.black54,
                                              )
                                            ]
                                          : [const BoxShadow()],
                                      color: kButtonColor,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(200),
                                          topRight: Radius.circular(200),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  child: Text(
                                    clickCounter != 0
                                        ? clickCounter.toString()
                                        : "التالي",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.currentIndex != widget.adkars.length - 1
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.currentIndex++;
                                  clickCounter = widget.adkars.values
                                      .elementAt(widget.currentIndex);
                                  prog = 0;
                                });
                              },
                              style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                              child: Icon(
                                CupertinoIcons.arrow_right_circle,
                                color: kButtonColor,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
