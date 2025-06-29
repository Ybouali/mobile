import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:advanced_weather_app/features/models/weather_model.dart';
import 'package:advanced_weather_app/features/models/weekly_weather_model.dart';
import 'package:advanced_weather_app/features/screens/currently_screen.dart';
import 'package:advanced_weather_app/features/screens/today_screen.dart';
import 'package:advanced_weather_app/features/screens/weekly_screen.dart';
import 'package:advanced_weather_app/features/services/network_service.dart';

class WeatherController extends GetxController {
  static WeatherController get instance => Get.find();

  // Variables
  final TextEditingController textFieldController = TextEditingController();
  final RxInt selectedIndex = 0.obs;
  late List<Widget> screen;
  final RxBool searchIsLoading = false.obs;
  final RxString location = ''.obs;
  final RxString city = ''.obs;
  final RxString country = ''.obs;
  final RxString state = ''.obs;
  final Rx<WeatherModel?> curr = Rx<WeatherModel?>(null);

  final RxInt numberTimeCallReq = 0.obs;
  final RxDouble currentLatitude = 0.0.obs;
  final RxDouble currentLongitude = 0.0.obs;
  final Rx<Map<int, String>> errorStrings = Rx<Map<int, String>>({
    1: 'Geolocation is not available, please enable it in your app settings !',
    2: 'The service connection is lost check your internet connection or try again later',
    3: 'Clould not find any result for the supplied address or coordinates',
  });
  final RxInt errorNumber = 1.obs;
  final Rx<List<WeatherModel>?> weatherDay = Rx<List<WeatherModel>?>(null);
  final Rx<List<WeeklyWeatherModel>?> weatherWeek =
      Rx<List<WeeklyWeatherModel>?>(null);
  final Rx<List<String>> suggestionList = Rx<List<String>>([]);
  final textFieldFocusNode = FocusNode();

  @override
  void onInit() {
    screen = [
      CurrentlyScreen(text: "Current"),
      TodayScreen(text: "Today"),
      WeeklyScreen(text: "Weekly"),
    ];

    Future.delayed(Duration.zero, () async {
      await getCurrentLocation();
    });

    super.onInit();
  }

  @override
  void onClose() {
    textFieldController.dispose();

    selectedIndex.close();
    searchIsLoading.close();
    location.close();
    city.close();
    country.close();
    state.close();
    curr.close();
    numberTimeCallReq.close();
    currentLatitude.close();
    currentLongitude.close();
    errorStrings.close();
    errorNumber.close();
    weatherDay.close();
    weatherWeek.close();

    super.onClose();
  }

  Future<void> getTheWeatherAndSetTheValues() async {
    if (textFieldController.text.isEmpty) {
      return;
    }
    final isConnected = await NetworkService.isConnected();
    if (!isConnected) {
      errorNumber.value = 2;
      return;
    }

    if (await _checkPermission()) {
      errorNumber.value = 1;
      return;
    }

    if (textFieldController.text.length < 6) {
      errorNumber.value = 3;
      return;
    }

    if (selectedIndex.value == 3) {
      selectedIndex.value = 0;
    }
    errorNumber.value = 0;
    getLanAndLongFromName();
    if (selectedIndex.value == 0) {
      // Current Screen
      curr.value = null;
      await getCurrentWeather();
    } else if (selectedIndex.value == 1) {
      // Today Screen
      weatherDay.value = null;
      await getTheDayWeather();
    } else if (selectedIndex.value == 2) {
      // Weekly Screen
      weatherWeek.value = null;
      await getTheWeekWeather();
    }
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  Future<void> getCurrentLocation() async {
    if (textFieldController.text.isNotEmpty) {
      textFieldController.clear();
    }
    final isConnected = await NetworkService.isConnected();
    if (!isConnected) {
      errorNumber.value = 2;
      return;
    }
    try {
      numberTimeCallReq.value += 1;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorNumber.value = 2;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorNumber.value = 1;
          return;
        }
      }

      if ((permission == LocationPermission.deniedForever ||
              permission == LocationPermission.denied) &&
          numberTimeCallReq.value >= 2) {
        numberTimeCallReq.value = 1;
        Get.defaultDialog(
          title: "Permission Required",
          content: const Text(
            "Location permission is permanently denied. Please enable it in the app settings.",
          ),
          confirm: ElevatedButton(
            onPressed: () {
              AppSettings.openAppSettings();
              Get.back();
            },
            child: const Text("Open Settings"),
          ),
          cancel: TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
        );

        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;

      if (currentLatitude.value == 0.0 || currentLongitude.value == 0.0) {
        errorNumber.value = 3;
      }

      await getNameFromPosition();

      await getTheWeatherAndSetTheValues();
    } catch (e) {
      errorNumber.value = 1;
    }
  }

  Future<void> getNameFromPosition() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLatitude.value,
      currentLongitude.value,
    );
    Placemark place = placemarks[0];

    city.value = place.locality!;
    state.value = place.administrativeArea!;
    country.value = place.country!;
    textFieldController.text = city.value;
  }

  void getLanAndLongFromName() async {
    try {
      List<Location> locations = await locationFromAddress(
        textFieldController.text,
      );

      Location loc = locations.first;
      currentLatitude.value = loc.latitude;
      currentLongitude.value = loc.longitude;
      getNameFromPosition();
    } catch (e) {
      // Just Ignoring the e
      errorNumber.value = 1;
    }
  }

  Future<void> fetchCitySuggestions() async {
    if (textFieldController.text.isEmpty) {
      return;
    }

    final apiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    final response = await http.get(
      Uri.parse(
        '$baseUrl?input=${textFieldController.text}&types=(cities)&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final predictions = data['predictions'] as List;
      suggestionList.value = predictions.take(5).map((p) {
        return p['description'] as String;
      }).toList();
      // print(suggestionList.value);
    } else {
      debugPrint("Failed to fetch suggestions");
    }
  }

  Future<void> getCurrentWeather() async {
    try {
      curr.value = null;
      final String url =
          "https://api.open-meteo.com/v1/forecast?"
          "latitude=${currentLatitude.value}&"
          "longitude=${currentLongitude.value}&"
          "current=temperature_2m,windspeed_10m&"
          "daily=temperature_2m_max,windspeed_10m_max&"
          "timezone=auto";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        curr.value = WeatherModel.fromJson(
          jsonDecode(res.body),
          _getWeatherDescription,
        );
      } else {
        debugPrint('Failed to load weather data: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Failed to fetch weather: $e');
    }
  }

  String getAnimationForCurrentWeather(String? weatherCondition) {
    if (weatherCondition == null || weatherCondition.isEmpty) {
      return "assets/animations/weather/sunny.json";
    }

    final String condition = weatherCondition.toLowerCase();

    if (condition.contains("rain") ||
        condition.contains("drizzle") ||
        condition.contains("shower") ||
        condition.contains("thunder") ||
        condition.contains("storm")) {
      return "assets/animations/weather/rain.json";
    }

    if (condition.contains("snow") ||
        condition.contains("blizzard") ||
        condition.contains("sleet") ||
        condition.contains("ice") ||
        condition.contains("hail")) {
      return "assets/animations/weather/snow.json";
    }

    if (condition.contains("mist") ||
        condition.contains("fog") ||
        condition.contains("haze")) {
      return "assets/animations/weather/cloud.json";
    }

    if (condition.contains("cloud") || condition.contains("overcast")) {
      return "assets/animations/weather/cloud.json";
    }

    if (condition.contains("clear") ||
        condition.contains("sunny") ||
        condition.contains("fair")) {
      return "assets/animations/weather/sunny.json";
    }

    if (condition.contains("tornado") ||
        condition.contains("hurricane") ||
        condition.contains("sandstorm") ||
        condition.contains("ash")) {
      return "assets/animations/weather/rain.json";
    }

    return "assets/animations/weather/sunny.json";
  }

  IconData getIconType(String? condition) {
    final String con = getAnimationForCurrentWeather(condition);

    final String getJsonCon = con.split("/").last;

    final List<String> listSplit = getJsonCon.split(".");

    final String getcon = listSplit[listSplit.length - 2];

    if (getcon == "sunny") {
      return Icons.wb_sunny_outlined;
    } else if (getcon == "rain") {
      return Icons.grain_outlined;
    } else if (getcon == "snow") {
      return Icons.ac_unit;
    } else if (getcon == "cloud") {
      return Icons.cloud;
    }

    return Icons.wb_sunny_outlined;
  }

  Future<void> getTheDayWeather() async {
    try {
      weatherDay.value = [];
      final String url =
          "https://api.open-meteo.com/v1/forecast?"
          "latitude=${currentLatitude.value}&"
          "longitude=${currentLongitude.value}&"
          "hourly=temperature_2m,windspeed_10m,weathercode&"
          "forecast_days=1&"
          "timezone=auto";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final hourlyData = data['hourly'] as Map<String, dynamic>;

        final itemCount = hourlyData['time']?.length ?? 0;

        weatherDay.value = List<WeatherModel>.generate(itemCount, (index) {
          final windSpeedKph =
              ((hourlyData['windspeed_10m']?[index]?.toDouble() ?? 0.0) * 3.6)
                  .roundToDouble();
          final weatherCode = hourlyData['weathercode']?[index] as int? ?? 0;

          return WeatherModel(
            tempC: hourlyData['temperature_2m']?[index]?.toDouble() ?? 0.0,
            windKph: windSpeedKph,
            date: DateTime.parse(hourlyData['time']?[index]),
            condition: _getWeatherDescription(
              weatherCode,
            ), // Add weather condition
          );
        });
      } else {
        weatherDay.value = [];
        debugPrint('Failed to load weather data: ${res.statusCode}');
      }
    } catch (e) {
      weatherDay.value = [];
      debugPrint('Failed to fetch weather: $e');
    }
  }

  Future<void> getTheWeekWeather() async {
    try {
      weatherWeek.value = [];
      final String url =
          "https://api.open-meteo.com/v1/forecast?"
          "latitude=${currentLatitude.value}&"
          "longitude=${currentLongitude.value}&"
          "daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_max&"
          "timezone=auto";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final dailyData = data['daily'] as Map<String, dynamic>;

        weatherWeek.value = List<WeeklyWeatherModel>.generate(
          dailyData['time']?.length ?? 0,
          (index) {
            return WeeklyWeatherModel(
              date: DateTime.parse(dailyData['time'][index]),
              minTempC:
                  (dailyData['temperature_2m_min'][index] as num?)
                      ?.toDouble() ??
                  0.0,
              maxTempC:
                  (dailyData['temperature_2m_max'][index] as num?)
                      ?.toDouble() ??
                  0.0,
              description: _getWeatherDescription(
                dailyData['weathercode'][index] as int? ?? 0,
              ),
              condition: _getWeatherDescription(
                dailyData['weathercode'][index] as int? ?? 0,
              ),
            );
          },
        );
      } else {
        weatherWeek.value = [];
        debugPrint('Failed to load weather data: ${res.statusCode}');
      }
    } catch (e) {
      weatherWeek.value = [];
      debugPrint('Failed to fetch weather: $e');
    }
  }

  String _getWeatherDescription(int weatherCode) {
    const descriptions = {
      0: 'Clear sky',
      1: 'Mainly clear',
      2: 'Partly cloudy',
      3: 'Overcast',
      45: 'Fog',
      48: 'Depositing rime fog',
      51: 'Light drizzle',
      53: 'Moderate drizzle',
      55: 'Dense drizzle',
      56: 'Light freezing drizzle',
      57: 'Dense freezing drizzle',
      61: 'Slight rain',
      63: 'Moderate rain',
      65: 'Heavy rain',
      66: 'Light freezing rain',
      67: 'Heavy freezing rain',
      71: 'Slight snow fall',
      73: 'Moderate snow fall',
      75: 'Heavy snow fall',
      77: 'Snow grains',
      80: 'Slight rain showers',
      81: 'Moderate rain showers',
      82: 'Violent rain showers',
      85: 'Slight snow showers',
      86: 'Heavy snow showers',
      95: 'Thunderstorm',
      96: 'Thunderstorm with slight hail',
      99: 'Thunderstorm with heavy hail',
    };

    return descriptions[weatherCode] ?? 'Unknown weather';
  }
}
