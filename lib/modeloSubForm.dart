import 'package:firebase_database/firebase_database.dart';

class SubFormulario {
  late String? key;
  late String campo;
  late String titulo;
  late bool requeridoCampo;
  late String tipoCampo;
  late String? subKey;

  SubFormulario(
      {this.key,
      required this.campo,
      required this.titulo,
      required this.requeridoCampo,
      required this.tipoCampo,
      this.subKey});

  SubFormulario.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    campo = snapshot.value;
    titulo = snapshot.value;
    requeridoCampo = snapshot.value;
    tipoCampo = snapshot.value;
    subKey = snapshot.value;
  }

  toJson() => {
        "campo": campo,
        "titulo": titulo,
        "requiereCampo": requeridoCampo,
        "tipoCampo": tipoCampo,
        "subkey": subKey
      };
}
