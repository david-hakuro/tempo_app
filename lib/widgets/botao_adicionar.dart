import 'package:flutter/material.dart';
import '../screens/formulario_clima.dart';

class BotaoAdicionar extends StatelessWidget {
  const BotaoAdicionar({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const FormClima(),
        );
      },
      shape: const CircleBorder(),
      backgroundColor: Colors.deepPurple[700],
      tooltip: 'Adicionar Local',
      child: const Icon(Icons.cloud),
    );
  }
}
