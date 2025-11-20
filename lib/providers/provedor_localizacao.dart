import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/localizacao.dart';

class ProvedorLocalizacao with ChangeNotifier {
  final _StorageService _storage = _StorageService();
  List<Localizacao> _localizacoes = [];
  bool _carregando = false;

  List<Localizacao> get localizacoes => [..._localizacoes];
  bool get carregando => _carregando;

  ProvedorLocalizacao() {
    _inicializar();
  }

  Future<void> _inicializar() async {
    _carregando = true;
    notifyListeners();

    _localizacoes = await _storage.carregar();

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarLocalizacao(String cidade, String estado) async {
    final novaLocalizacao = Localizacao(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cidade: cidade.trim(),
      estado: estado.trim(),
      dataCriacao: DateTime.now(),
    );

    _localizacoes.add(novaLocalizacao);
    notifyListeners();
    await _storage.salvar(_localizacoes);
  }

  Future<void> atualizarLocalizacao(String id, String cidade, String estado) async {
    final index = _localizacoes.indexWhere((loc) => loc.id == id);
    if (index != -1) {
      _localizacoes[index] = _localizacoes[index].copyWith(
        cidade: cidade.trim(),
        estado: estado.trim(),
      );
      notifyListeners();
      await _storage.salvar(_localizacoes);
    }
  }

  Future<void> excluirLocalizacao(String id) async {
    _localizacoes.removeWhere((loc) => loc.id == id);
    notifyListeners();
    await _storage.salvar(_localizacoes);
  }

  Localizacao? obterLocalizacaoPorId(String id) {
    try {
      return _localizacoes.firstWhere((loc) => loc.id == id);
    } catch (_) {
      return null;
    }
  }
}

class _StorageService {
  static const String _key = 'localizacoes';

  Future<List<Localizacao>> carregar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_key) ?? [];
      return jsonList
          .map((json) => Localizacao.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      debugPrint('Erro ao carregar dados: $e');
      return [];
    }
  }

  Future<void> salvar(List<Localizacao> localizacoes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = localizacoes
          .map((loc) => jsonEncode(loc.toJson()))
          .toList();
      await prefs.setStringList(_key, jsonList);
    } catch (e) {
      debugPrint('Erro ao salvar dados: $e');
    }
  }
}
