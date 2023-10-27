import 'package:e_weatherapp/model/model.dart';
import 'package:e_weatherapp/service/service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('ff2a788310eb4dfcba775839230406');
  Weather? _weather;

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    }
    catch (e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'Cloudy':
        return 'assets/cloud.json';
      case 'Mist':
        return 'assets/mist.json';
      case 'Fog':
        return 'assets/mist.json';
      case 'Light rain':
        return 'assets/rain.json';
      case 'Heavy rain':
        return 'assets/thunder.json';
      case 'Sunny' || 'Clear':
        return 'assets/sunny,json';
      default:
        return 'assets/rain.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 25,
              image: AssetImage('assets/dot.png')
            ),

            Text(
              _weather?.city ?? "loading city..",
              style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 20),
              ),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text(
              '${_weather?.temperature.round()} °C',
              style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 50),
            ),

            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400, fontSize: 20),
              )
          ],
        ),
      ),
    );
  }
}