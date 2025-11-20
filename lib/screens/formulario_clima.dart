import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_crud/models/localizacao.dart';
import '../providers/provedor_localizacao.dart';

class FormClima extends StatefulWidget{
  final Localizacao? localizacao;

  const FormClima({super.key, this.localizacao});

  @override
  State<StatefulWidget> createState() => _FormClimaState();
}

class _FormClimaState extends State<FormClima>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  bool _salvando = false;

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
      setState(() {
        _salvando = true;
      });

      final provider = Provider.of<ProvedorLocalizacao>(context, listen: false);

      try {
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
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
                duration: Duration(seconds: 2),
              ),
            );
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
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          final mensagem = e.toString().contains('Local não encontrado') 
            ? 'Local não encontrado. Verifique os dados informados.'
            : 'Erro ao salvar local';
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(mensagem),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _salvando = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.localizacao != null ? 'Editar Local' : 'Novo Local',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a cidade';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _estadoController,
              decoration: const InputDecoration(
                labelText: 'Estado',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.map),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o estado';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvando ? null : _salvarLocalizacao,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _salvando 
                ? const SizedBox(
                    height: 20, 
                    width: 20, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  )
                : Text(widget.localizacao != null ? 'Atualizar' : 'Adicionar'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
