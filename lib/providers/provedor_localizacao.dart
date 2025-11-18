import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/localizacao.dart';

class ProvedorLocalizacao with ChangeNotifier {
  List<Localizacao> _localizacoes = [];
  bool _carregando = false;

  List<Localizacao> get localizacoes => _localizacoes;
  bool get carregando => _carregando;

  ProvedorLocalizacao() {
    _carregarLocalizacoes();
  }

  Future<void> _carregarLocalizacoes() async {
    _carregando = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final localizacoesJson = prefs.getStringList('localizacoes') ?? [];
      _localizacoes = localizacoesJson
          .map((json) => Localizacao.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Erro ao carregar locais: $e');
    }

    _carregando = false;
    notifyListeners();
  }

  Future<void> _salvarLocalizacoes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localizacoesJson = _localizacoes
          .map((localizacao) => jsonEncode(localizacao.toJson()))
          .toList();
      await prefs.setStringList('localizacoes', localizacoesJson);
    } catch (e) {
      print('Erro ao salvar locais: $e');
    }
  }

  Future<void> adicionarLocalizacao(String cidade, String estado) async {
    final localizacao = Localizacao(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cidade: cidade.trim(),
      estado: estado.trim(),
      dataCriacao: DateTime.now(),
    );

    _localizacoes.add(localizacao);
    await _salvarLocalizacoes();
    notifyListeners();
  }

  Future<void> atualizarLocalizacao(String id, String cidade, String estado) async {
    final indice = _localizacoes.indexWhere((loc) => loc.id == id);
    if (indice != -1) {
      _localizacoes[indice] = _localizacoes[indice].copyWith(
        cidade: cidade.trim(),
        estado: estado.trim(),
      );
      await _salvarLocalizacoes();
      notifyListeners();
    }
  }

  Future<void> excluirLocalizacao(String id) async {
    _localizacoes.removeWhere((loc) => loc.id == id);
    await _salvarLocalizacoes();
    notifyListeners();
  }

  Localizacao? obterLocalizacaoPorId(String id) {
    try {
      return _localizacoes.firstWhere((loc) => loc.id == id);
    } catch (e) {
      return null;
    }
  }
}

