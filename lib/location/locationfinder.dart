import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationFinder {
  List locations = [
    // ayat train station
    {
      "location name": "Ayat train Station",
      "latitude": 9.021328,
      "longitude": 38.87198,
    },
    // cmc
    {
      "location name": "CMC",
      "latitude": 9.021121,
      "longitude": 38.872594,
    },
    //civil service university
    {
      "location name": "Civil Service University",
      "latitude": 9.023256,
      "longitude": 38.833048,
    },
    //megenagna
    {
      "location name": "Megenagna",
      "latitude": 9.020906,
      "longitude": 38.802237,
    },
    //estifanos
    {
      "location name": "St. Estifanos",
      "latitude": 9.011081,
      "longitude": 38.748706,
    },
    //kality
    {
      "location name": "Kality",
      "latitude": 9.937995,
      "longitude": 38.763034,
    },
    //gofa
    {
      "location name": "Gofa mebrat hayil",
      "latitude": 8.963972,
      "longitude": 38.743009,
    },
    // gerji roba
    {
      "location name": "Gerji Roba",
      "latitude": 8.994746,
      "longitude": 38.813554,
    },
    // bole michael
    {
      "location name": "Bole Michael",
      "latitude": 8.981614,
      "longitude": 38.777223,
    },
    //ayer tena
    {
      "location name": "Ayer tena bus station",
      "latitude": 8.983132,
      "longitude": 38.698259,
    },
    // merkato
    {
      "location name": "Mercato",
      "latitude": 9.030587,
      "longitude": 38.739649,
    },
    //arat kilo
    {
      "location name": "Arat kilo",
      "latitude": 9.034403,
      "longitude": 38.763093,
    },
    // meskel square
    {
      "location name": "Meskele Square",
      "latitude": 8.981717,
      "longitude": 38.760118,
    },
  ];
  Position? currentUserPosition;
  var myLocation= '';
  var distanceInMeter;

  List sortedLocation = [];
  Future<List> getLocation() async {
    List distanceList = [];
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location Service are disabled');
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location Permissioin denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permission are denied permanently, we can not request permission");
    }
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    for(var location in locations){
      var distance = await Geolocator.distanceBetween(position.latitude, position.longitude,
          location['latitude'], location['longitude']);
      var locationName = location['location name'];
      var roundedDistance = (distance/1000).toStringAsFixed(2);
      distanceList.add(roundedDistance);
    }
    return distanceList;
  }
}