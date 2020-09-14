import 'package:flutter/material.dart';
import 'package:izijob/misc/MainScreen.dart';
//import 'package:izijob/footer.dart';
//mport 'package:izijob/registroVista.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Izi Job',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Footer(),s
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
