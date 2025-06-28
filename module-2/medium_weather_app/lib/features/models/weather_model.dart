class WeatherModel {
  final double tempC;
  final double windKph;
  final DateTime date;

  WeatherModel({
    required this.tempC,
    required this.windKph,
    required this.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, bool isDaily) {
    return WeatherModel(
      tempC:
          isDaily
              ? json['daily']['temperature_2m_max'][0]
              : json['current']['temperature_2m'],
      windKph:
          isDaily
              ? json['daily']['windspeed_10m_max'][0]
              : json['current']['windspeed_10m'],
      date: DateTime.parse(
        isDaily ? json['daily']['time'][0] : json['current']['time'],
      ),
    );
  }
}
