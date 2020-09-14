import 'package:izijob/clases/trabajo.dart';

class Cachuelo extends Trabajo {
  String estado
      //,
      //vacantes,
      // sueldo
      ;

  Cachuelo(
      String titulo,
      String descripcion,
      String telefono,
      String email,
      String categoria,
      this.estado,
      String fechaPublicado,
      String tiempoPublicado,
      int idUser)
      : super(titulo, descripcion, telefono, email, categoria, fechaPublicado,
            tiempoPublicado, idUser);
}
