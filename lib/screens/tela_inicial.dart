import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_crud/screens/tela_detalhes_clima.dart';
import '../providers/provedor_localizacao.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/lista_localizacoes.dart';
import '../widgets/botao_adicionar.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indiceAtual = 1;

  @override
  Widget build(BuildContext context) {
    final telas = [
      const TelaDetalhesClima(),
      Consumer<ProvedorLocalizacao>(
        builder: (context, provider, child) {
          if (provider.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.localizacoes.isEmpty) {
            return const NenhumEstadoWidget();
          }

          return ListaLocalizacoes(localizacoes: provider.localizacoes);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CLIMATE',
        ),
        centerTitle: true,
      ),
      body: telas[_indiceAtual],
      floatingActionButton: const BotaoAdicionar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.bubble_chart),
              color: _indiceAtual == 0 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () {
                setState(() {
                  _indiceAtual = 0;
                });
              },
              tooltip: 'Clima Local',
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.place),
              color: _indiceAtual == 1 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () {
                setState(() {
                  _indiceAtual = 1;
                });
              },
              tooltip: 'Lugares',
            ),
          ],
        ),
      ),
    );
  }
}
