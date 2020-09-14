import 'package:flutter/material.dart';
import 'package:izijob/empleoVista.dart';
import 'package:izijob/cachueloVista.dart';
import 'package:izijob/contactarVista.dart';

class Footer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FooterState();
  }
}

class _FooterState extends State<Footer> {
  int _currentIndex = 0;
  final List<Widget> _children = [EmpleoVista(), CachueloVista(), ContactarVista()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.work),
            title: new Text('Empleo'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), title: Text('Cachuelo')),
          BottomNavigationBarItem(
            icon: new Icon(Icons.call),
            title: new Text('Contactar'),
          ),
        ],
        selectedItemColor: Colors.amber[900],
        backgroundColor: Colors.blue[900],
        unselectedItemColor: Colors.white,
      ),
    );
  }

  void onTabTapped(int index) {
    //Cambia los valores y recarga los datos en pantalla
    setState(() {
      _currentIndex = index;
    });
  }
}
