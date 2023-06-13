import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Bouton',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Files',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Non définie',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: (index) => onItemTapped(index),
    );
  }
}
