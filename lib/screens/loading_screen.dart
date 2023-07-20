import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climateapp/services/location.dart';
import 'package:climateapp/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:climateapp/services/weather.dart';

class LoadingScreen extends StatefulWidget {



  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {

  void getlocationData() async{

    var weatherData = await weatherModel_().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: weatherData);
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    getlocationData();
    super.initState();
    }
  //get data from openweathermap.com using http's get and response

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
