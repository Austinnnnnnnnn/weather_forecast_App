import 'package:flutter/material.dart';
import 'package:weather_forecast/UI/Network.dart';
import 'package:weather_forecast/UI/weatherForecastModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'IconsHelper.dart';


class weatherForecast extends StatefulWidget {
  const weatherForecast({Key key}) : super(key: key);

  @override
  _weatherForecastState createState() => _weatherForecastState();
}

class _weatherForecastState extends State<weatherForecast> {
  Future<weatherForecastModel> forecastObject;
  String cityName="Auckland";
  @override
  void initState() {

    super.initState();
    forecastObject=Network().getWeatherForcast(cityName: cityName);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 13),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
            child: TextField(
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
              ),
              decoration: InputDecoration(
                hintText: "Enter city name",
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5),),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 0.5)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black,width: 2)
                ),
              ),
              onChanged: (value){
                cityName=value;
                forecastObject=new Network().getWeatherForcast(cityName: cityName);
              },
            ),
          ),
          Container(
              child: FutureBuilder(
                  future: forecastObject,
                  builder: (BuildContext context, AsyncSnapshot <weatherForecastModel> snapshot) {
                    if (snapshot.hasData){
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data.city.name, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),),
                                Text(snapshot.data.list[0].dtTxt.split(" ")[0]),
                                SizedBox(height: 20,),
                                Text("${((snapshot.data.list[0].main.temp)-273.15).toStringAsFixed(2)}°C",style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),),
                                Center(child: getWeatherIcon(snapshot.data.list[0].weather[0].main, 120 )),
                                SizedBox(height: 10,),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.temperatureHigh,color: Colors.red.withOpacity(0.8),size: 23),
                                            Text("${(snapshot.data.list[0].main.tempMax-273.15).toStringAsFixed(2)} °C",style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black
                                            ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.temperatureLow,color: Colors.red.withOpacity(0.8),size: 23,),
                                            Text("${(snapshot.data.list[0].main.tempMin-273.15).toStringAsFixed(2)} °C",style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black
                                            ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.wind,color: Colors.red.withOpacity(0.8),size: 23),
                                            Text("${snapshot.data.list[0].wind.speed.toString()} mi/h",style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("5-DAY WEATHER FORECAST FOR EACH 3 HOURS",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            height:2200,
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                                separatorBuilder: (context,index)=>SizedBox(height: 5),
                                itemCount: snapshot.data.list.length-1,
                              itemBuilder: (context,index)=>ClipRRect(
                                child:Container(
                                  width:200,
                                  height:50,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(13)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("${snapshot.data.list[index+1].dtTxt}"),
                                      getWeatherIcon(snapshot.data.list[index+1].weather[0].main, 20 ),
                                      Text("${(snapshot.data.list[index+1].main.tempMax-273.15).toStringAsFixed(2)} °C" ,
                                        style:TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text("${(snapshot.data.list[index+1].main.tempMin-273.15).toStringAsFixed(2)} °C" ,
                                        style:TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),),
                                    ],
                                  ),
                              ),
                            ),
                            ),
                          ),
                        ],
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
            },
          ),
          ),
        ],
      ),
    );
  }
}
