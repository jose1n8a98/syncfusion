import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/values_models.dart';

class ValuesService {
  String id;
  ValuesService(this.id);
  final String _rootUrl =
      "http://pruebas.ushops.tech/iobits-generales/api/prueba/testgetData";

  Future<List<ValuesModel>> getpotentiometer() async {
    List<ValuesModel> resultValues = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.post(url,
          body: ({
            'device_id': id,
          }));

      List<ValuesModel> potenc = [];

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        for (var item in jsonData) {
          potenc.add(ValuesModel(item["potenciometro"], item["date"]));
          //pott.add(item["potenciometro"].toDouble());
          //print(item["potenciometro"]);
        }
        return potenc;
      } else {
        throw Exception("Fallo la coneccion");
      }
    } catch (ex) {
      return resultValues;
    }
  }
}
