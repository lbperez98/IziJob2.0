import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:izijob/footer.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';


class RegistroVista extends StatefulWidget{
  @override
  _RegistroVistaState createState() => _RegistroVistaState();
    
  }
  
  class _RegistroVistaState extends State<RegistroVista>{
  
    final _formkey = GlobalKey<FormState>();
    final globalKey = GlobalKey<ScaffoldState>();
    
    String usuario;
    DateTime initial=DateTime.now();
    String fechanac,
    correo,
    clave;
    int idUser;  
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Registrate a IziJob"),
      backgroundColor: Colors.blue[900],
      centerTitle: true,),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          
          child: Form(
            key: _formkey,
            child: Scrollbar(
              child: ListView(children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: TextFormField(
                    decoration: InputDecoration(
                            labelText: 'Nombre de usuario',
                            
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Por favor, ingresa un usuario'
                                : null;
                          },
                          onSaved: (value) {
                            return usuario = value;
                          } ,
                          ),
                          ),
                new ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: DateTimeFormField(
                initialValue: initial,
                label: "Date Time",
                validator: (DateTime dateTime) {
                  if (dateTime == null) {
                    return "Date Time Required";
                  }
                  return null;
                },
                onSaved: (DateTime dateTime) { fechanac = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
                return fechanac;
                },
              ),
                ),          

              new ListTile(
                leading: const Icon(Icons.email),
                title: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',

                  ),
                  validator: (value){
                            return value.isEmpty
                                ? 'Por favor, un correo valido'
                                : null;
                          },
                          onSaved: (value) {
                            return usuario = value;
                          } ,
                  ),
              ),
              new ListTile(
                leading: const Icon(Icons.email),
                title: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',

                  ),
                  validator: (value){
                            return value.isEmpty
                                ? 'Por favor, ingrese una contraseña'
                                : null;
                          },
                          onSaved: (value) {
                            return usuario = value;
                          } ,
                  ),
              ),

              SizedBox(height: 20.0),
              new RaisedButton(
                color: Colors.blue[800],
                child: Text('Registrarme',
                      style: TextStyle(color: Colors.white10),
                      ),
                onPressed: uploadStatusContacto,      
              )
                                  
              ]
              ,)
              ,)
                
              )
              
              )),
      );
    
    

  }

    void guardarToDatabase() {

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "usuario": usuario,
      "fechanac": fechanac,
      "correo": correo,
      "clave" : clave,
      "idUser": 1
    };
    print(data);
    ref.child("Usuario").push().set(data);
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

}