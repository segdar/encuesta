import 'package:firebase_database/firebase_database.dart';

class Formulario {
  late String? key;
  late String titulo;
  late String descripcion;
  late String? keyLink;

  Formulario(
      {this.key,
      required this.titulo,
      required this.descripcion,
      this.keyLink});

  Formulario.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    titulo = snapshot.value;
    descripcion = snapshot.value;
    keyLink = snapshot.value;
  }

  toJson() =>
      {"titulo": titulo, "descripcion": descripcion, "keylink": keyLink};
}
