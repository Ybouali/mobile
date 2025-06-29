class WeatherModel {
  final double tempC;
  final double windKph;
  final DateTime date;
  final String condition;

  WeatherModel({
    required this.tempC,
    required this.windKph,
    required this.date,
    required this.condition,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
    String Function(int) weatherConditionMapper,
  ) {
    final windSpeedKph =
        (json['current']['windspeed_10m'] as num).toDouble() * 3.6;

    final weatherCode = json['current']['weathercode'] as int? ?? 0;
    final condition = weatherConditionMapper(weatherCode);

    return WeatherModel(
      tempC: (json['current']['temperature_2m'] as num).toDouble(),
      windKph: windSpeedKph,
      date: DateTime.parse(json['current']['time']),
      condition: condition,
    );
  }
}
