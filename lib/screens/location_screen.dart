import 'package:climateapp/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:climateapp/utilities/constants.dart';
import 'dart:math';
import 'package:climateapp/services/weather.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  weatherModel_ weatherModel = weatherModel_();
 int temprature=0;
String weatherICon = '';
 String cityname='';

 String message = '';
 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   updateUI(widget.locationweather);
 }
  void updateUI(dynamic weatherdata){
   setState(() {
     if(weatherdata== null){
        temprature =0;
        weatherICon = "Error";
        message = "unable to getting weather data";
        cityname = '';
        return;
     }
     double temp = weatherdata['main']['temp']-273.15;
     temprature = temp.toInt();
     var condition = weatherdata['weather'][0]['id'];
     weatherICon= weatherModel.getWeatherIcon(condition);
     message = weatherModel.getMessage(temprature);
     cityname = weatherdata['name'];
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                     var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }),
                      );
                      if(typedName!=null){
                       var weatherData = await weatherModel.getCityWeather(typedName);
                      updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),




              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temprature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherICon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          cityname,
                          style: TextStyle(fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

