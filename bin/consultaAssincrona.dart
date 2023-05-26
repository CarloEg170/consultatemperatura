import 'dart:convert';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

Future<void> main() async {
  var url = Uri.parse("https://api.github.com/users/CarloEg170");
  final headers = {
    'Autorization':
        'Bearer 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'
  };
  var response = await http.get(url, headers: headers);
  // print(response.body);
  var data = jsonDecode(response.body);

  // DateTime dataCriacao = DateTime.parse(data["created_at"]);
  // DateTime dataAtualizacao = DateTime.parse(data["updated_at"]);
  // intl.DateFormat formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm");

  print("Usuario: ${data["login"]}");
  print("Data de Criação: ${formataData(data["created_at"])}");
  print("Ultimo Acesso: ${formataData(data["updated _at"])}");
  print("Endpoint Repositório: ${data["repos_url"]}");

  url = Uri.parse(data["repos_url"]);
  response = await http.get(url, headers: headers);
  data = jsonDecode(response.body);

  print("Repositorios: ");
  for (final item in data) {
    print("\t Nome: ${item['name']} <---> Url: ${item['clone_url']}");
  }
}

String formataData(String data, {String formato = "dd/MM/yyyy HH:mm"}) {
  final dataConversao = DateTime.parse(data);
  final formatoSaida = intl.DateFormat(formato);
  return formatoSaida.format(dataConversao);
}
