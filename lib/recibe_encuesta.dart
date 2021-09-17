import 'package:flutter/material.dart';

class FrmLlenadoEcuesta extends StatefulWidget {
  static const String ROUTE = "/FrmLlenado";
  FrmLlenadoEcuesta({Key? key}) : super(key: key);

  @override
  _FrmLlenadoEcuestaState createState() => _FrmLlenadoEcuestaState();
}

class _FrmLlenadoEcuestaState extends State<FrmLlenadoEcuesta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Llena Encuesta'),
      ),
      body: Container(
        child: Column(
          children: [Text('Llena los Datos')],
        ),
      ),
    );
  }
}
