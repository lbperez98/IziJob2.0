import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:izijob/footer.dart';
import 'package:izijob/sendmail.dart';

class PublicarContacto extends StatefulWidget {
  @override
  _PublicarContactoState createState() => _PublicarContactoState();
}

class _PublicarContactoState extends State<PublicarContacto>{
  final _formkey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  String tfnombre,
  tfedad,
  tfprofesion,
  tfservicio,
  tftelefono,
  tfcorreo,
  tfcategoria;

  Widget build(BuildContext context){
    return Scaffold(key: globalKey,
      appBar: AppBar(
        title: Text("Publicar Contacto"),
                backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: metodos,
          )
        ],
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formkey,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    new ListTile(
                        leading: const Icon(Icons.edit),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Ej: Víctor Moyano ...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa dos nombres y dos apellidos'
                                : null;
                          },
                          onSaved: (value) {
                            return tfnombre = value;
                          },
                        )),
                    new ListTile(
                      leading: const Icon(Icons.cake),
                      title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Edad',
                          hintText: 'Ej: Señor(a) de tal edad...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingresa la edad';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return tfedad = value;
                        },
                      ),
                    ),
                    
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
                            return tftelefono = value;
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
                            return tfcorreo = value;
                          },
                        )),
                    new ListTile(
                        leading: const Icon(Icons.category),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Categorías',
                            hintText: 'Ej: salud, música, cocina...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa al menos 1 categoría.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfcategoria = value;
                          },
                        )),
                    new ListTile(
                        leading: const Icon(Icons.business_center),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profesión: ',
                            hintText: 'Ej: cocineros, música, ingenieros...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa al menos 1 profesión.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfprofesion = value;
                          },
                        )), 
                    new ListTile(
                        leading: const Icon(Icons.assignment),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Servicios',
                            hintText: 'Ej: cocineros, música, ingenieros...',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa al menos 1 servicio.'
                                : null;
                          },
                          onSaved: (value) {
                            return tfservicio = value;
                          },
                        )),                                               
                  ],
                ),
              ),
            ),
          ),
        ),
      ),);
  }

  void metodos(){
    uploadStatusContacto();
    enviarMail(tfcorreo);
  }

  void uploadStatusContacto() async {
    if (validarForm()) {
      guardarToDatabase();
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Footer();
      }));
    }
  }

    void guardarToDatabase() {

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "nombre": tfnombre,
      "edad": tfedad,
      "telefono": tftelefono,
      "correo": tfcorreo,
      "categoria": tfcategoria,
      "profesion": tfprofesion,
      "servicio": tfservicio,
      "idUser": 1
    };
    print(data);
    ref.child("Contacto").push().set(data);
  }

    bool validarForm() {
    final form = _formkey.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      form.save();
      final snackBar = SnackBar(content: Text('Contacto Publicado'));
      globalKey.currentState.showSnackBar(snackBar);
      return true;
    }
    return false;
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