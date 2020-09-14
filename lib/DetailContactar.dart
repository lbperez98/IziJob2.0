import 'package:flutter/material.dart';
import 'package:izijob/clases/contactar.dart';

class DetailContactar extends StatelessWidget{
  final Contacto contacto;

  DetailContactar({Key key, @required this.contacto }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("${this.contacto.nombre}," + "${this.contacto.profesion}" ),
    backgroundColor: Colors.blue[900],),
    body: ListView(padding: EdgeInsets.all(10.0),
    children: <Widget>[
      Row(children: [
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
      ],),
          SizedBox(height: 5),
          Text("Quedaría mejor una descripcion sobre la persona que aparece en este menu"),
          SizedBox(height: 15),
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
              const Icon(Icons.phone, size: 10,),
              SizedBox(width: 15),
              Text(
                "${contacto.telefono}",
                style: TextStyle(
                  fontFamily: 'Varela',
                ),
              )
            ],
          ),
                    Row(
            children: [
              const Icon(Icons.mail),
              SizedBox(width: 15),
              Text(
                "${contacto.correo}",
                style: TextStyle(
                  fontFamily: 'Varela',
                ),
              )
            ],
          ),
          SizedBox(height: 15),
            Text(
              "Profesión: ",
              style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(children: [
            const Icon(Icons.business_center),
            SizedBox(width: 15),
            Text(
            "${contacto.profesion}",
            style: TextStyle(
                  fontFamily: 'Varela',
                ),
          )
          ],),
          SizedBox(height: 15),
          Text("Servicios: ",
          style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(children: [
            const Icon(Icons.assignment),
            SizedBox(width: 15),
            Text(
              "${contacto.servicio}",
                  style: TextStyle(
                  fontFamily: 'Varela',
                ),
            )
          ],),
          SizedBox(height: 15),
          Text("Categorías: ",
          style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(children: [
            const Icon(Icons.category),
            SizedBox(width: 15),
            Text(
              "${contacto.categoria}",
                  style: TextStyle(
                  fontFamily: 'Varela',
                ),
            )
          ],)
    ],)
    ,);
  } 
}