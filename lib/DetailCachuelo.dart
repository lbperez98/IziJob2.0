import 'package:flutter/material.dart';
import 'package:izijob/clases/cachuelo.dart';

class DetailCachuelo extends StatelessWidget {
  final Cachuelo cachuelo;

  DetailCachuelo({Key key, @required this.cachuelo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${cachuelo.titulo}"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.description),
              SizedBox(width: 15),
              Text(
                "Descripción: ",
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text("${cachuelo.descripcion}"),
          SizedBox(height: 15),

          /*Row(
            children: [
              const Icon(Icons.star),
              SizedBox(width: 15),
              Text(
                "Experiencia: ",
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text("${empleo.experiencia}"),
          SizedBox(height: 15),
          */
          /*Row(
            children: [
              const Icon(Icons.monetization_on),
              SizedBox(width: 15),
              Text(
                "Sueldo: ",
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text("${empleo.sueldo}"),
          SizedBox(height: 15),*/
          Text(
            "Contactos: ",
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.phone),
              SizedBox(width: 15),
              Text(
                "${cachuelo.telefono}",
                style: TextStyle(
                  fontFamily: 'Varela',
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.mail),
              SizedBox(width: 15),
              Text(
                "${cachuelo.email}",
                style: TextStyle(
                  fontFamily: 'Varela',
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.category),
              SizedBox(width: 15),
              Text(
                "Categoría: ",
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text("${cachuelo.categoria}"),
          SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.supervisor_account),
              SizedBox(width: 15),
              Text(
                "Estado : ",
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text("${cachuelo.estado}"),
            ],
          ),
        ],
      ),
    );
  }
}
