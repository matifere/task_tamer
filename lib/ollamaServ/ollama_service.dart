import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class OllamaService {
  Future<String> obtenerRespuesta(String prompt) async {
    try {
      final String baseUrl = dotenv.env['IA_URL']!;
      final url = Uri.parse(baseUrl);

      final Map<String, dynamic> cuerpoPeticion = {
        "model": "qwen2.5:14b",
        "prompt": prompt,
        "stream": false,
      };

      final respuesta = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(cuerpoPeticion),
      );

      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body);

        return datos['response'];
      } else {
        return 'Error del servidor: Código ${respuesta.statusCode}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }
}
