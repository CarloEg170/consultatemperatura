import 'package:http/http.dart' as http;

Future<void> main() async {
  final url = Uri.parse('https://viacep.com.br/ws/17520120/json/');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
  }
}
