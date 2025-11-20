import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/localizacao.dart';
import '../models/clima.dart';
import '../services/servico_clima.dart';
import '../providers/provedor_localizacao.dart';

class TelaDetalhesClima extends StatefulWidget {
  const TelaDetalhesClima({super.key});

  @override
  State<TelaDetalhesClima> createState() => _TelaDetalhesClimaState();
}

class _TelaDetalhesClimaState extends State<TelaDetalhesClima> {
  final ServicoClima _servicoClima = ServicoClima();
  Clima? _clima;
  bool _carregando = false;
  String? _mensagemErro;
  Localizacao? _localSelecionado;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProvedorLocalizacao>(context, listen: false);
      if (provider.localizacoes.isNotEmpty) {
        setState(() {
          _localSelecionado = provider.localizacoes.first;
        });
        _carregarClima();
      }
    });
  }

  Future<void> _carregarClima() async {
    if (_localSelecionado == null) return;

    setState(() {
      _carregando = true;
      _mensagemErro = null;
    });

    try {
      final clima = await _servicoClima.obterClima(
        _localSelecionado!.cidade,
        _localSelecionado!.estado,
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
    return Consumer<ProvedorLocalizacao>(
      builder: (context, provider, child) {
        if (provider.localizacoes.isEmpty) {
          return const Center(
            child: Text('Cadastre um local para ver os detalhes'),
          );
        }

        if (_localSelecionado != null &&
            !provider.localizacoes.contains(_localSelecionado)) {
             _localSelecionado = provider.localizacoes.first;
             _carregarClima();
        } else if (_localSelecionado == null && provider.localizacoes.isNotEmpty) {
             _localSelecionado = provider.localizacoes.first;
             _carregarClima();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Localizacao>(
                      value: _localSelecionado,
                      isExpanded: true,
                      hint: const Text('Selecione um local'),
                      items: provider.localizacoes.map((Localizacao local) {
                        return DropdownMenuItem<Localizacao>(
                          value: local,
                          child: Text(
                            '${local.cidade}, ${local.estado}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Localizacao? novoLocal) {
                        if (novoLocal != null) {
                          setState(() {
                            _localSelecionado = novoLocal;
                          });
                          _carregarClima();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_carregando)
                const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_mensagemErro != null)
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 8),
                      Text(_mensagemErro!),
                      TextButton(
                        onPressed: _carregarClima,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                )
              else if (_clima != null)
                Column(
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
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
