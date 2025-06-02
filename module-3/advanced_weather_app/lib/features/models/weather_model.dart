class WeatherModel {
  final double tempC;
  final double windKph;
  final DateTime date;

  WeatherModel({
    required this.tempC,
    required this.windKph,
    required this.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, bool date) {
    final List<String> time = json['current']['last_updated'].toString().split(
      " ",
    );

    return WeatherModel(
      tempC: json['current']['temp_c'],
      windKph: json['current']['wind_kph'],
      date: date ? DateTime.parse(time[0]) : DateTime.parse(time[0]),
    );
  }
}
