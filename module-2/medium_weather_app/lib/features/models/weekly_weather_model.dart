class WeeklyWeatherModel {
  final double minTempC;
  final double maxTempC;
  final DateTime date;
  final String description;

  WeeklyWeatherModel({
    required this.date,
    required this.minTempC,
    required this.maxTempC,
    required this.description,
  });
}
