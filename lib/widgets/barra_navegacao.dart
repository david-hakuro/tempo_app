import 'package:flutter/material.dart';

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            label: "climal local",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "lugares",
          ),
        ]
    );
  }
}
