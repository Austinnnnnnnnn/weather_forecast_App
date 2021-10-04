import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_forecast/UI/weatherForecastModel.dart';


class Network{
  Future <weatherForecastModel> getWeatherForcast ({String cityName}) async{
    var finalUrl= "https://api.openweathermap.org/data/2.5/forecast?q="+cityName+"&appid=ec8ab65a712dc7447282943ab6b96875";
    final response = await get(Uri.parse(finalUrl));
    print("URL :${Uri.encodeFull(finalUrl)}");

    if (response.statusCode==200){
      print("weather data : ${response.body}");
      return weatherForecastModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error getting weather forecast");
    }

  }
}