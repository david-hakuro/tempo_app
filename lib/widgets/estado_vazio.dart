import 'package:flutter/material.dart';

class NenhumEstadoWidget extends StatelessWidget {
  const NenhumEstadoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum local cadastrado',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text:'Toque no botão '),
                WidgetSpan(child: Icon(Icons.cloud, color: Colors.grey,)),
                TextSpan(text: ' para adicionar'),
              ]
            ),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
