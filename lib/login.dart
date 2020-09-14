//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:izijob/footer.dart';
//import 'package:firebase_database/firebase_database.dart';

import 'package:izijob/clases/usuario.dart';

import 'globals.dart' as globals;

import 'registro.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

//enum SingingCharacter { empleo, cachuelo }

class _LoginState extends State<Login> {
  final _formLogin = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  List<Usuario> usuarioList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference usuarioRef =
        FirebaseDatabase.instance.reference().child("Usuario");
    usuarioRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      usuarioList.clear();

      for (var individualKey in keys) {
        Usuario user = Usuario(
          data[individualKey]['idUSer'],
          data[individualKey]['nombre'],
          data[individualKey]['usuario'],
          data[individualKey]['correo'],
          data[individualKey]['fechaCreacion'],
          data[individualKey]['clave'],
        );
        usuarioList.add(user);
      }
    });
  }

  final myController = TextEditingController();
  final myControllerCon = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    myControllerCon.dispose();
    super.dispose();
  }

  String tfUsuario, tfContrasena;
  //tfExp,
  //tfEstado,
  //tfSueldo,
  //tfTelefono,
  //tfEmail,
  //tfCategoria;

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        /*actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: uploadStatusCachuelo,
          )
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formLogin,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      'assets/Izi.PNG',
                      width: 50,
                      height: 150,
                    ),
                    new ListTile(
                        leading: const Icon(Icons.person),
                        title: TextFormField(
                          controller: myController,
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            //hintText: 'Ej: Necesito empleador...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingrese su usuario'
                                : null;
                          },
                          onSaved: (value) {
                            //globals.user = value;
                            return tfUsuario = value;
                            //return globals.user = value;
                          },
                        )),
                    new ListTile(
                      leading: const Icon(Icons.lock),
                      title: TextFormField(
                        controller: myControllerCon,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          //hintText: 'Ej: Señor(a) de tal edad...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingresa la contraseña';
                          }
                          return null;
                        },
                        /*onSaved: (value) {
                          //globals.clave = value;
                          return tfContrasena = value;
                          //return globals.clave = value;
                        },*/
                      ),
                    ),
                    SizedBox(height: 20.0),
                    new RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("Ingresar"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed:
                          ingresarMain /*() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          globals.isLoggedIn = true;
                          return Footer();
                        }));
                      }*/
                      ,
                    ),
                    SizedBox(height: 10.0),
                    new RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("Registrarse"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          //return PublicarCachuelo();
                          return Registro();
                        }));
                      },
                    ),
                    SizedBox(height: 10.0),
                    new RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("Ingresar como invitado"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          //return PublicarCachuelo();
                          globals.isLoggedIn = false;
                          return Footer();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validarLogin() {
    //if ("libruce" == "libruce") {
    for (Usuario x in usuarioList) {
      if (x.usuario == myController.text) {
        if (x.clave == myControllerCon.text) {
          return "true";
        }
      }
    }
    return "false";
  }

  //Valida que esté todos los campos llenos
  bool validarForm() {
    final form = _formLogin.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      //form.save();
      return true;
    }
    return false;
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text("Datos Incorrectos")),
            children: <Widget>[
              Center(child: Text("El usuario que ha ingresado ")),
              Center(child: Text("no se encuentra registrado.")),
              Center(child: Text("Compruebe los datos o ")),
              Center(child: Text("Regístrese. Gracias!")),
              Center(
                  child: FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.pop(ctx);
                      })),
            ],
          );
        });
  }

  void ingresarMain() {
    if (validarForm()) {
      if (validarLogin() == "true") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          globals.isLoggedIn = true;
          return Footer();
        }));
      } else {
        _showDialog(context);
      }
    }
  }
}
