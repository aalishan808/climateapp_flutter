import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climateapp/services/location.dart';
import 'package:climateapp/services/networking.dart';
const apikey = '77bd05f15bf117e73f4c8c588dfae7d3';
class weatherModel_ {


  String cityname_ ='';

  Future<dynamic> getCityWeather(String cityName_) async{
    NetworkHelper networkHelper  = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName_&appid=$apikey&units = metric');
    var weatherData = await networkHelper.getData();
    return weatherData;

  }
  Future<dynamic> getLocationWeather() async{
    location Location = location();
    await Location.getCurrentLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(Location.latitude, Location.longitude);
    cityname_ = placemarks.reversed.last.locality.toString();
    NetworkHelper networkHelper  = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityname_&appid=$apikey&units = metric');
    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
