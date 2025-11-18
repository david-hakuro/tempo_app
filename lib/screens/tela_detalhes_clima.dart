import 'package:flutter/material.dart';
import '../models/localizacao.dart';
import '../models/clima.dart';
import '../services/servico_clima.dart';

class TelaDetalhesClima extends StatefulWidget {
  final Localizacao localizacao;

  const TelaDetalhesClima({super.key, required this.localizacao});

  @override
  State<TelaDetalhesClima> createState() => _TelaDetalhesClimaState();
}

class _TelaDetalhesClimaState extends State<TelaDetalhesClima> {
  final ServicoClima _servicoClima = ServicoClima();
  Clima? _clima;
  bool _carregando = true;
  String? _mensagemErro;

  @override
  void initState() {
    super.initState();
    _carregarClima();
  }

  Future<void> _carregarClima() async {
    setState(() {
      _carregando = true;
      _mensagemErro = null;
    });

    try {
      final clima = await _servicoClima.obterClima(
        widget.localizacao.cidade,
        widget.localizacao.estado,
      );

      if (clima != null) {
        setState(() {
          _clima = clima;
          _carregando = false;
        });
      } else {
        setState(() {
          _mensagemErro = 'Não foi possível obter dados do clima';
          _carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        _mensagemErro = 'Erro ao carregar dados: $e';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.localizacao.cidade}, ${widget.localizacao.estado}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarClima,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _mensagemErro != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _mensagemErro!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _carregarClima,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar novamente'),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Nota: Você precisa configurar sua chave da API OpenWeatherMap no arquivo servico_clima.dart',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : _clima != null
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  if (_clima!.icone.isNotEmpty)
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${_clima!.icone}@2x.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${_clima!.temperatura.toStringAsFixed(1)}°C',
                                    style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _clima!.descricao.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.water_drop,
                                        color: Colors.blue[400],
                                        size: 28,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Umidade',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${_clima!.umidade.toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red[400],
                                        size: 28,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Local',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${_clima!.cidade}, ${_clima!.estado}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(child: Text('Dados não disponíveis')),
    );
  }
}

