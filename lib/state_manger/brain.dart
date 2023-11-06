import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:khushoo/elements/constans.dart';

class Brain extends ChangeNotifier {
  int colorIndex = 0;
  bool _clicked = false;
  var networkStatus;
  int _index = 1;
  dynamic _jsonData;
  String _location = 'please turn on your location';
  bool arabic = true;

  int get index => _index;
  bool get clicked => _clicked;
  String get location => _location;
  bool done = false;

  // Click reaction.
  void click() {
    _clicked = !_clicked;
    notifyListeners();
  }

  void switchTheme() {
    colorIndex++;
    colorIndex > 6 ? colorIndex = 0 : null;
    notifyListeners();
  }

  void switchLanguage() {
    arabic = !arabic;
    notifyListeners();
  }

  void setNetworkStatus(var status) {
    networkStatus = status;
  }

  // getting the network status
  dynamic getNetworkStatus() {
    return networkStatus;
  }

  // set index.
  void setIndex(index) {
    _index = index;
    notifyListeners();
  }

  // determine the current position.
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    getData(await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium));
  }

  // get the current location data.
  dynamic getData(Position location) async {
    notifyListeners();
    Uri locationUrl =
        Uri.https('api.bigdatacloud.net', '/data/reverse-geocode-client', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'localityLanguage': arabic ? 'ar' : 'en'
    });

    Uri timesUrl = Uri.http('api.aladhan.com', '/v1/timings', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'method': "4",
    });

    // print(locationUrl);

    http.Response locationResponse = await http.get(locationUrl);
    http.Response timeResponse = await http.get(timesUrl);
    if (locationResponse.statusCode == 200 ||
        locationResponse.statusCode == 201) {
      _location = (await jsonDecode(locationResponse.body)['city']);
      notifyListeners();
    } else {
      print("ERROR");
    }

    if (timeResponse.statusCode == 200 || locationResponse.statusCode == 201) {
      _jsonData = await jsonDecode(timeResponse.body);
      notifyListeners();
    } else {
      print("ERROR");
    }
  }

  Future<void> waitForPrep(context) async {
    await determinePosition().then(
        (value) => getJson() == null ? waitForPrep(context) : done = true);

    notifyListeners();
  }

  // return the json code.
  dynamic getJson() {
    return _jsonData;
  }
}
