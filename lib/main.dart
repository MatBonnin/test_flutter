import 'package:flutter/material.dart';
import 'custom_navigation_bar.dart';
import 'button_widget.dart';
import 'wire_module.dart';
// Assurez-vous d'importer votre WireModule widget ici

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Bar with Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var titleTopBar = '';
  var listPage = ['Module boutton','Module de fils','Module non défini'];

  // Ajoutez votre ButtonWidget et WireModule ici
  static final List<Widget> _pages = <Widget>[
    ButtonWidget(), // Votre ButtonWidget
    WireModule(),   // Votre WireModule widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      titleTopBar=listPage[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleTopBar)),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Votre CustomNavigationBar reste inchangé

// Ajoutez votre WireModule widget ici. Assurez-vous qu'il est un StatelessWidget ou StatefulWidget
