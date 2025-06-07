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
      _goToErrorPage(2);
      return;
    }

    if (await _checkPermission()) {
      _goToErrorPage(1);
      return;
    }

    if (textFieldController.text.length < 6) {
      _goToErrorPage(3);
      return;
    }

    if (selectedIndex.value == 3) {
      selectedIndex.value = 0;
    }
    getLanAndLongFromName();
    if (selectedIndex.value == 0) {
      // Current Screen
      await getCurrentWeather();
    } else if (selectedIndex.value == 1) {
      // Today Screen
      await getTheDayWeather();
    } else if (selectedIndex.value == 2) {
      // Weekly Screen
      await getTheWeekWeather();
    }
  }

  void _goToErrorPage(int n) {
    selectedIndex.value = 3;
    errorNumber.value = n;
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
      _goToErrorPage(2);
      return;
    }
    try {
      numberTimeCallReq.value += 1;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _goToErrorPage(1);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _goToErrorPage(1);
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
        _goToErrorPage(3);
      }

      await getNameFromPosition();

      await getTheWeatherAndSetTheValues();
    } catch (e) {
      _goToErrorPage(1);
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
      throw Exception("Failed to fetch suggestions");
    }
  }

  Future<void> getCurrentWeather() async {
    try {
      final apiKeyWeather = dotenv.env['WEATHER_API_KEY'];

      final String url =
          "http://api.weatherapi.com/v1/current.json?key=$apiKeyWeather&q=${currentLatitude.value},${currentLongitude.value}";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        curr.value = WeatherModel.fromJson(jsonDecode(res.body), false);
      } else if (res.statusCode == 401) {
        throw Exception('Invalid API key or unauthorized access');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
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

  Future<void> getTheDayWeather() async {
    try {
      final apiKeyWeather = dotenv.env['WEATHER_API_KEY'];

      final String url =
          "http://api.weatherapi.com/v1/forecast.json?key=$apiKeyWeather&q=${currentLatitude.value},${currentLongitude.value}&days=1&aqi=no&alerts=no";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final hourlyData = data['forecast']['forecastday'][0]['hour'] as List;

        weatherDay.value = hourlyData.map((hDWeather) {
          return WeatherModel(
            tempC: hDWeather['temp_c']?.toDouble() ?? 0.0,
            windKph: hDWeather['wind_kph']?.toDouble() ?? 0.0,
            date: DateTime.parse(hDWeather['time']),
            condition: "",
          );
        }).toList();
      } else if (res.statusCode == 401) {
        weatherDay.value = [];
        throw Exception('Invalid API key or unauthorized access');
      } else {
        weatherDay.value = [];
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      weatherDay.value = [];
      throw Exception('Failed to fetch weather: $e');
    }
  }

  Future<void> getTheWeekWeather() async {
    try {
      final apiKeyWeather = dotenv.env['WEATHER_API_KEY'];

      final String url =
          "http://api.weatherapi.com/v1/forecast.json?key=$apiKeyWeather&q=${currentLatitude.value},${currentLongitude.value}&days=7&aqi=no&alerts=no";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final hourlyData = data['forecast']['forecastday'] as List;

        weatherWeek.value = hourlyData.map((day) {
          final dayData = day['day'];
          return WeeklyWeatherModel(
            date: DateTime.parse(day['date']),
            minTempC: dayData['mintemp_c']?.toDouble() ?? 0.0,
            maxTempC: dayData['maxtemp_c']?.toDouble() ?? 0.0,
            description: dayData['condition']['text'] ?? 'No description',
          );
        }).toList();
      } else if (res.statusCode == 401) {
        weatherWeek.value = [];
        throw Exception('Invalid API key or unauthorized access');
      } else {
        weatherWeek.value = [];
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      weatherWeek.value = [];
      throw Exception('Failed to fetch weather: $e');
    }
  }
}
