import 'package:firebase_database/firebase_database.dart';

class User {
  late String? id;
  late String nombre;
  late String password;

  User({
    this.id,
    required this.nombre,
    required this.password,
  });

  User.map(dynamic obj) {
    this.nombre = obj['nombre'];
    this.password = obj['password'];
  }

  User.fromSnapShot(DataSnapshot snapshot) {
    id = snapshot.key;
    nombre = snapshot.value['nombre'];
    password = snapshot.value['password'];
  }
}
