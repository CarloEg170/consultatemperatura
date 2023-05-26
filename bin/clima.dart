import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;

Future<void> main() async {
  // final dio = Dio();
  // final response = await dio.get(
  //     "https://api.openweathermap.org/data/2.5/weather?lat=-22.2139&lon=-49.9458&appid=ce50126e0cd3dc989263b4096067ffc7&lang=pt-br");

  var url = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: 'data/2.5/weathr',
      queryParameters: {
        'lat': "-22.2139",
        'lon': "49.9458",
        'appid': "ce50126e0cd3dc989263b4096067ffc7&"
      });

  final dio = Dio();
  var response = await dio.get(url.toString());

  if (response.statusCode == 200) {
    final data = response.data;

    print(
        "A temperatura de ${data['name']} é de ${kelvinToCelsius(data['main']['temp'])}°C, no dia ${timestampUnixToDataHora(data['dt'])}");
  } else {
    print('Erro ao fazer requisição: ${response.statusCode}');
  }
}

String kelvinToCelsius(double tempKelvin) {
  double tempCelsius = tempKelvin - 273.15;
  return tempCelsius.toStringAsPrecision(4);
}

String timestampUnixToDataHora(int timestamp) {
  DateTime data =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  final formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm");
  DateTime dataLocal = data.toLocal();
  return formatoSaida.format(dataLocal);
}
