import 'package:izijob/clases/trabajo.dart';

class Empleo extends Trabajo{
  String experiencia,
  vacantes,
  sueldo;

  Empleo(String titulo, String descripcion, String telefono, String email, String categoria, String fechaPublicado, String tiempoPublicado, int idUser, this.experiencia, this.sueldo, this.vacantes) :
  super(titulo, descripcion, telefono, email, categoria, fechaPublicado, tiempoPublicado, idUser);

  

  
}