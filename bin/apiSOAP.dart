import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() {
  retornaNomesPaises().then(
    (nomePais) {
      print(nomePais);
    },
  ).catchError(
    (error) {
      print('Erro: $error');
    },
  );
}

Future<List<String>> retornaNomesPaises() async {
  //três aspas simples
  final soapEnvelope = '''<?xml version="1.0" encoding-"utf-8"?>
  <soap12:Envolope xmlns::soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:body>
  <ListOfContryNamesByName xmlns="https://www.oorsprong.org/websamples.contryinfo">
  <ListOfContryNamesByName>
  </soap12:Body>
  </soap12:Envelope>''';

  final response = await http.post(
    Uri.parse(
        "https://www.oorsprong.org/websamples.contryinfo/ContryInfoService.wso"),
    headers: {
      'Content-Type': 'text/xml; charset=utf-8',
      'SOAPAction':
          'https://www.oorsprong.org/websamples.contryinfo/ListOfContryNamesByName',
    },
    body: soapEnvelope,
  );

  if (response.statusCode == 200) {
    final listaDePaises = XmlDocument.parse(response.body)
        .findAllElements('m:ListOfCOntryNamesByNameResult');
    if (listaDePaises.isNotEmpty) {
      final nomeDoPais = listaDePaises.first.innerText
          .split(',')
          .map((name) => name.trim())
          .toList();
      return nomeDoPais;
    } else {
      throw 'Responsta inválida do servidor';
    }
  } else {
    throw 'falha na requisição: ${response.statusCode}';
  }
}
