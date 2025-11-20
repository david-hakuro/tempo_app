import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/clima.dart';

class ServicoClima {
  static const String chaveApi = 'd7310ed6fc9ad21d356f4e39c86b4f65';
  static const String urlBase = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Clima?> obterClima(String cidade, String estado) async {
    try {
      String consulta = '$cidade,$estado,BR';

      final url = Uri.parse('$urlBase?q=$consulta&appid=$chaveApi&units=metric&lang=pt_br');
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final dados = json.decode(resposta.body);
        return Clima.fromJson(dados);
      } else if (resposta.statusCode == 404) {
        final urlCidade = Uri.parse('$urlBase?q=$cidade,BR&appid=$chaveApi&units=metric&lang=pt_br');
        final respostaCidade = await http.get(urlCidade);

        if (respostaCidade.statusCode == 200) {
          final dados = json.decode(respostaCidade.body);
          return Clima.fromJson(dados);
        }
      }

      return null;
    } catch (e) {
      print('Erro ao buscar clima: $e');
      return null;
    }
  }
}

