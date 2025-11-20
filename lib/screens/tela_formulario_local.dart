import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provedor_localizacao.dart';
import '../models/localizacao.dart';

class TelaFormularioLocal extends StatefulWidget {
  final Localizacao? localizacao;

  const TelaFormularioLocal({super.key, this.localizacao});

  @override
  State<TelaFormularioLocal> createState() => _TelaFormularioLocalState();
}

class _TelaFormularioLocalState extends State<TelaFormularioLocal> {
  final _formKey = GlobalKey<FormState>();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.localizacao != null) {
      _cidadeController.text = widget.localizacao!.cidade;
      _estadoController.text = widget.localizacao!.estado;
    }
  }

  @override
  void dispose() {
    _cidadeController.dispose();
    _estadoController.dispose();
    super.dispose();
  }

  Future<void> _salvarLocalizacao() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProvedorLocalizacao>(context, listen: false);

      if (widget.localizacao != null) {
        await provider.atualizarLocalizacao(
          widget.localizacao!.id,
          _cidadeController.text,
          _estadoController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Local atualizado com sucesso'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        await provider.adicionarLocalizacao(
          _cidadeController.text,
          _estadoController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Local adicionado com sucesso'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.localizacao != null ? 'Editar Local' : 'Novo Local'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  hintText: 'Ex: São Paulo',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o nome da cidade';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _estadoController,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  hintText: 'Ex: SP',
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o estado';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarLocalizacao,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.localizacao != null ? 'Atualizar' : 'Adicionar',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

