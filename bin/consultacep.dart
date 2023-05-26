import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .then((response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data[1]['title']);
      // print(data[2]['body']);
      print("Usuario: ${data[0]["userId"]}");
      for (int i = 0; i < data.length; i++) {
        print("${i + 1}º Item");
        print("\tCódigo: ${data[i]["id"]}");
        print("\tTitulo: ${data[i]["title"]}");
        print("\tCorpo: ${data[i]["body"]}");
      }

      print("---------------------   OUTRO JEITO  --------------------");
      for (final item in data) {
        print("Codigo: ${item['id']}");
        print("\tTitulo: ${item['title']}");
        print("\tCorpo: ${item['body']}");
      }
    } else {
      print('Erro ao fazer requesição: ${response.statusCode}');
    }
  });
}
