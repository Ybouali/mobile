class WeeklyWeatherModel {
  final double minTempC;
  final double maxTempC;
  final DateTime date;
  final String description;
  final String condition;

  WeeklyWeatherModel({
    required this.date,
    required this.condition,
    required this.minTempC,
    required this.maxTempC,
    required this.description,
  });
}
