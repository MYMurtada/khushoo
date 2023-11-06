import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:khushoo/state_manger/brain.dart';
import 'package:location/location.dart';
import 'elements/constans.dart';
import 'package:flutter/material.dart';
import 'pages/control_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'pages/onbording_page.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Preyer Time',
            channelDescription: 'The time of the preyer is comming',
            defaultColor: kBackgroundColor,
            channelShowBadge: true,
            onlyAlertOnce: true,
            importance: NotificationImportance.High,
            criticalAlerts: true)
      ],
      debug: true);
  runApp(ChangeNotifierProvider(
    create: (context) => Brain(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ControlPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyApp()));
    }
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission().then((value) => checkFirstSeen());
  }

  Location location = Location();

  Future<void> _requestLocationPermission() async {
    try {
      var result = context.read<Brain>().networkStatus;
      PermissionStatus permissionStatus = await location.requestPermission();
      result = await InternetAddress.lookup('google.com');
      if (permissionStatus == PermissionStatus.granted &&
          (result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
        print("Done!");
      } else {
        _requestLocationPermission();
        print("The location is not provided!");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ControlPage();
  }
}
