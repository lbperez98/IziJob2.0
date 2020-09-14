import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:izijob/clases/cachuelo.dart';
import 'package:izijob/publicarCachuelo.dart';
import 'package:intl/intl.dart';

import 'DetailCachuelo.dart';

import 'globals.dart' as globals;

class CachueloVista extends StatefulWidget {
  @override
  _CachueloVistaState createState() => _CachueloVistaState();
}

class _CachueloVistaState extends State<CachueloVista> {
  List<Cachuelo> cachueloList = [];
  List<Cachuelo> filteredCachueloList = [];
  bool isBusqueda = false;

  @override
  void initState() {
    super.initState();
    DatabaseReference cachueloRef =
        FirebaseDatabase.instance.reference().child("Cachuelo");
    cachueloRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      cachueloList.clear();

      for (var individualKey in keys) {
        Cachuelo cachuelo = Cachuelo(
            data[individualKey]['titulo'],
            data[individualKey]['descripcion'],
            data[individualKey]['telefono'],
            data[individualKey]['email'],
            data[individualKey]['categoria'],
            data[individualKey]['estado'],
            data[individualKey]['fechaP'],
            data[individualKey]['tiempoP'],
            data[individualKey]['idUser']);

        List<String> fecha = cachuelo.fechaPublicado.split("/");
        String dia = fecha[0];
        String mes = fecha[1];
        String ano = fecha[2];

        var dbTimeKey = DateTime.now();
        var formatDate = DateFormat('d/M/y');
        //var formatTime = new DateFormat.jm();

        String date = formatDate.format(dbTimeKey);
        List<String> fecha2 = date.split("/");
        String dia2 = fecha2[0];
        String mes2 = fecha2[1];
        String ano2 = fecha2[2];

        if (int.parse(ano2) > int.parse(ano)) {
          cachuelo.estado = "Inactivo";
          cachueloRef
              .child(individualKey)
              .child("estado")
              //.push()
              .set("Inactivo");
        } else if (int.parse(ano2) == int.parse(ano)) {
          if (int.parse(mes2) > int.parse(mes)) {
            cachuelo.estado = "Inactivo";
            cachueloRef
                .child(individualKey)
                .child("estado")
                //.push()
                .set("Inactivo");
          } else if (int.parse(mes2) == int.parse(mes)) {
            if (int.parse(dia2) - int.parse(dia) >= 3) {
              cachuelo.estado = "Inactivo";
              cachueloRef
                  .child(individualKey)
                  .child("estado")
                  //.push()
                  .set("Inactivo");
            }
          }
        }

        //String time = formatTime.format(dbTimeKey);

        //Agrega y ordena
        setState(() {
          if (cachuelo.estado == "Activo") {
            cachueloList.add(cachuelo);
            filteredCachueloList.add(cachuelo);
            cachueloList
                .sort((c, d) => d.fechaPublicado.compareTo(c.fechaPublicado));
            filteredCachueloList
                .sort((c, d) => d.fechaPublicado.compareTo(c.fechaPublicado));
          }
        });
      }
    });
  }

  void _filterCachuelos(value) {
    setState(() {
      filteredCachueloList = cachueloList
          .where((cachuelo) =>
              cachuelo.categoria.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cachuelo'),
        backgroundColor : Colors.blue[900],
        centerTitle: true,
      ),
      body: Center(

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor : Colors.blue[900],
        onPressed: (){  
               
        },
        child: const Icon(Icons.add),
      ),  
      //backgroundColor : Colors.green,
      
      //bottomNavigationBar: Footer()
    );
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: !isBusqueda
            ? Text('Cachuelo')
            : TextField(
                onChanged: (value) {
                  //print(value);
                  _filterCachuelos(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Filtra por Categoría",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isBusqueda
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isBusqueda = false;
                      filteredCachueloList = cachueloList;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isBusqueda = true;
                    });
                  },
                )
        ],
      ),

      body: Container(
          //padding: const EdgeInsets.all(5.0),
          child: filteredCachueloList.length == 0
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No hay Cachuelos :(",
                            style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        CircularProgressIndicator()
                      ]),
                )
              : ListView.builder(
                  itemCount: filteredCachueloList.length,
                  itemBuilder: (_, index) {
                    return postsCachuelo(filteredCachueloList[index]
                        /*cachueloList[index].titulo,
                        cachueloList[index].fechaPublicado,
                        cachueloList[index].descripcion,
                        cachueloList[index].categoria,*/
                        );
                  })),

      floatingActionButton: botonCachuelo(),

      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PublicarCachuelo();
          }));
        },
        child: const Icon(Icons.add),
      ),*/
      //backgroundColor: Colors.green,
      //bottomNavigationBar: Footer()
    );
  }

  Widget botonCachuelo() {
    if (globals.isLoggedIn) {
      return FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PublicarCachuelo();
            //return Login();
          }));
        },
        child: const Icon(Icons.add),
      );
    }
  }

  Widget postsCachuelo(Cachuelo cachuelo) {
    return Card(
        elevation: 10.0,
        margin: EdgeInsets.all(14.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailCachuelo(cachuelo: cachuelo),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      cachuelo.titulo,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      //style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      //cachuelo.fechaPublicado.split("/")[0],
                      cachuelo.fechaPublicado,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                /*Text(
                  cachuelo.tiempoPublicado.split(":")[0],
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.0,
                ),*/
                Text(
                  cachuelo.descripcion,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Categoría: " + cachuelo.categoria,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Estado: " + cachuelo.estado,
                    style: Theme.of(context).textTheme.caption,
                    /*style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )*/
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
