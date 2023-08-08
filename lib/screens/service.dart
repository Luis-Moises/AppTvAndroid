
import 'package:evaluation_app/screens/model.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final _weather = WeatherFactory('642ff7634ec9c242da2d3d9eb6546c37');

  Future<WeatherData> getWeather(String cityName) async {
    try {
      final weather = await _weather.currentWeatherByCityName(cityName);
      return WeatherData(
        cityName: weather.areaName!,
        temperature: weather.temperature!.celsius!.toDouble().roundToDouble(),
        description: weather.weatherDescription!,
        iconUrl: weather.weatherIcon!,
      );
    } catch (e) {
      throw Exception('Error al obtener los datos del clima');
    }
  }
}

