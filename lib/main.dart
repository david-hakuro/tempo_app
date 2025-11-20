import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provedor_localizacao.dart';
import 'screens/tela_inicial.dart';
import 'utils/themes.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProvedorLocalizacao(),
      child: MaterialApp(
        title: 'Clima App',
        debugShowCheckedModeBanner: false,
        theme: Themes.temaEscuro,
        home: const TelaInicial(),
      ),
    );
  }
}
