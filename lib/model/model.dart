class Weather {
  final String city;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.city, 
    required this.temperature, 
    required this.mainCondition,
    });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      city: json['location']['name'], 
      temperature: json['current']['temp_c'].toDouble(), 
      mainCondition: json['current']['condition']['text'],
    );
  }
}