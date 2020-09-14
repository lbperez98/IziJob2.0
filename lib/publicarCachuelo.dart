//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izijob/footer.dart';

class PublicarCachuelo extends StatefulWidget {
  @override
  _PublicarCachueloState createState() => _PublicarCachueloState();
}

//enum SingingCharacter { empleo, cachuelo }

class _PublicarCachueloState extends State<PublicarCachuelo> {
  final _formKey = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  String tfTitulo,
      tfDescripcion,
      //tfExp,
      tfEstado,
      //tfSueldo,
      tfTelefono,
      tfEmail,
      tfCategoria;

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Publicar Cachuelo'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: uploadStatusCachuelo,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    new ListTile(
                        leading: const Icon(Icons.title),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Título',
                            hintText: 'Ej: Necesito empleador...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa el título'
                                : null;
                          },
                          onSaved: (value) {
                            return tfTitulo = value;
                          },
                        )),
                    new ListTile(
                      leading: const Icon(Icons.description),
                      title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          hintText: 'Ej: Señor(a) de tal edad...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingresa la descripción';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return tfDescripcion = value;
                        },
                      ),
                    ),
                    /*new ListTile(
                      leading: const Icon(Icons.star),
                      title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Experiencia',
                          hintText: 'Ej: Experiencia en dicho campo...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingresa la experiencia necesaria';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return tfExp = value;
                        },
                      ),
                    ),*/
                    /*new ListTile(
                        leading: const Icon(Icons.monetization_on),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Sueldo',
                            hintText: 'Ingresa el posible sueldo',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa el sueldo.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfSueldo = value;
                          },
                        )),*/
                    /*new ListTile(
                        leading: const Icon(Icons.supervisor_account),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Vacantes',
                            hintText: 'Ej: 1, 2-4, Por ver...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingrese números de vacantes.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfVacantes = value;
                          },
                        )),*/
                    new ListTile(
                        leading: const Icon(Icons.contact_phone),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Teléfonos',
                            hintText: 'Ej: 098542261,(04)254789...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa número(s) telefónico(s).'
                                : null;
                          },
                          onSaved: (value) {
                            return tfTelefono = value;
                          },
                        )),
                    new ListTile(
                        leading: const Icon(Icons.contact_mail),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mails',
                            hintText: 'E-mails separado por comas.',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa correo(s) electrónico(s).'
                                : null;
                          },
                          onSaved: (value) {
                            return tfEmail = value;
                          },
                        )),
                    new ListTile(
                        leading: const Icon(Icons.category),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Categorías',
                            hintText: 'Ej: cocineros, música, ingenieros...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa al menos 1 categoría.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfCategoria = value;
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //backgroundColor: Colors.green,
    );
  }

  //Guardamos texto
  void guardarToDatabase() {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('d/M/y');
    var formatTime = new DateFormat.jm();

    String date = formatDate.format(dbTimeKey);
    //print (date);

    String time = formatTime.format(dbTimeKey);
    //print (time);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "titulo": tfTitulo,
      "descripcion": tfDescripcion,
      //"experiencia": tfExp,
      "estado": "Activo",
      //"sueldo": tfSueldo,
      "telefono": tfTelefono,
      "email": tfEmail,
      "categoria": tfCategoria,
      "fechaP": date,
      "tiempoP": time,
      "idUser": 1
    };
    print(data);
    ref.child("Cachuelo").push().set(data);
  }

  //Valida que esté todos los campos llenos
  bool validarForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      form.save();
      final snackBar = SnackBar(content: Text('Cachuelo Publicado'));
      globalKey.currentState.showSnackBar(snackBar);
      return true;
    }
    return false;
  }

  void uploadStatusCachuelo() async {
    if (validarForm()) {
      guardarToDatabase();
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Footer();
      }));
    }
  }

  TextFormField textFormFieldFunction(
      String labelText, String hintText, String tfTexto, String msgError) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        return value.isEmpty ? msgError : null;
      },
      onSaved: (value) {
        return tfTexto = value;
      },
    );
  }
}
