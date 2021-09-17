//import 'package:encuesta/frmCreaFrom.dart';
import 'package:encuesta/frmCreaFrom.dart';
import 'package:encuesta/linkDynamic.dart';
import 'package:encuesta/recibe_encuesta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Encuesta',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/LinkDynamic',
        routes: {
          '/': (context) => MyHomePage(title: 'Encuesta'),
          '/FrmCreaEncuesta': (context) => FrmCreaFrom(),
          '/FrmLlenado': (context) => FrmLlenadoEcuesta(),
          '/LinkDynamic': (context) => MainScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  static const String ROUTE = "/";
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _txtUsuario = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtCodigo = TextEditingController();
  final productReference = FirebaseDatabase.instance.reference().child('Form');
  final productReference2 =
      FirebaseDatabase.instance.reference().child('SubForm');

  //int _counter = 0;
  //User usuario = User(nombre: 'darwin', password: '123');

  void _incrementCounter() {
    setState(() {
      //_counter++;
      Navigator.pushNamed(context, '/FrmCreaEncuesta');

      //productReference2.push().set({'textosubForm': _counter});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _txtUsuario,
                decoration: InputDecoration(
                    hintText: 'Usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                validator: (texto) {
                  if (texto!.isEmpty) {
                    return 'Campo vacio';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _txtPassword,
                decoration: InputDecoration(
                    hintText: 'Pasword',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                validator: (texto) {
                  if (texto!.isEmpty) {
                    return 'Campo vacio';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 100),
              TextFormField(
                controller: _txtCodigo,
                decoration: InputDecoration(
                    hintText: 'Codigo Encuesta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
