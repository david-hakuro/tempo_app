import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_crud/models/localizacao.dart';
import 'package:weather_crud/models/clima.dart';
import 'package:weather_crud/screens/formulario_clima.dart';
import 'package:weather_crud/services/servico_clima.dart';
import '../providers/provedor_localizacao.dart';

class ListaLocalizacoes extends StatelessWidget {
  final List<Localizacao> localizacoes;

  const ListaLocalizacoes({super.key, required this.localizacoes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: localizacoes.length,
      itemBuilder: (context, index) {
        final localizacao = localizacoes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    localizacao.cidade,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                FutureBuilder<Clima?>(
                  future: ServicoClima().obterClima(localizacao.cidade, localizacao.estado),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final clima = snapshot.data!;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            'https://openweathermap.org/img/wn/${clima.icone}.png',
                            width: 32,
                            height: 32,
                            errorBuilder: (_, __, ___) => const Icon(Icons.cloud, size: 24, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${clima.temperatura.toStringAsFixed(0)}°C',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(localizacao.estado),
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'editar') {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => FormClima(localizacao: localizacao),
                  );
                } else if (value == 'excluir') {
                  _mostrarDialogoExclusao(context, localizacao);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'editar',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.grey),
                      SizedBox(width: 12),
                      Text('Editar'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'excluir',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Excluir', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarDialogoExclusao(
      BuildContext context,
      Localizacao localizacao,
      ) {
    final provider = Provider.of<ProvedorLocalizacao>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja excluir ${localizacao.cidade}, ${localizacao.estado}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              provider.excluirLocalizacao(localizacao.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Local excluído com sucesso'),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
