import 'package:encuesta/modeloForm.dart';
import 'package:encuesta/modeloSubForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class FrmCreaFrom extends StatefulWidget {
  static const String ROUTE = "/FrmCreaEncuesta";
  FrmCreaFrom({Key? key}) : super(key: key);

  @override
  _FrmCreaFromState createState() => _FrmCreaFromState();
}

class _FrmCreaFromState extends State<FrmCreaFrom> {
  final _txtNombreEncuesta = TextEditingController();
  final _txtDescripcionEncuesta = TextEditingController();
  final _txtNombreCampo = TextEditingController();
  final _txtTituloCampo = TextEditingController();

  bool _requerido = false;
  List<String> _tiposCampos = ['Texto', 'Numero', 'Fecha'];
  List<SubFormulario> _detalleSubform = [];
  String _valorDefecto = 'Texto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encuensta'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: _txtNombreEncuesta,
                decoration: InputDecoration(labelText: 'Nombre Encuesta')),
            TextField(
                controller: _txtDescripcionEncuesta,
                decoration: InputDecoration(labelText: 'Descripcion')),
            SizedBox(height: 15),
            ListTile(
              title: Text(
                'Agregar Detalle',
              ),
              onTap: () {
                _detalleEncuesta(context);
              },
            ),
            _listadoDetalle(context),
            _gregarDatos()
          ],
        ),
      ),
    );
  }

  _gregarDatos() {
    return ElevatedButton(
        onPressed: () async {
          final productReference =
              FirebaseDatabase.instance.reference().child('Encuestas/Form/');
          final productReference2 =
              FirebaseDatabase.instance.reference().child('Encuestas/SubForm/');
          var unikey = productReference.push().key;
          Formulario form = Formulario(
              titulo: _txtNombreEncuesta.text,
              descripcion: _txtDescripcionEncuesta.text);
          await productReference.child(unikey).set(form.toJson());

          _detalleSubform.forEach((element) async {
            final deta = SubFormulario(
                campo: element.campo,
                titulo: element.titulo,
                requeridoCampo: element.requeridoCampo,
                tipoCampo: element.tipoCampo,
                subKey: unikey);
            await productReference2.push().set(deta.toJson());
          });
          setState(() {
            _detalleSubform = [];
            _txtDescripcionEncuesta.clear();
            _txtNombreEncuesta.clear();
          });
        },
        child: Text('Agregar'));
  }

  _detalleEncuesta(contexto) {
    return showDialog(
        context: contexto,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detalle Encuestas'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  TextField(
                      controller: _txtNombreCampo,
                      decoration: InputDecoration(labelText: 'Nombre Campo')),
                  TextField(
                      controller: _txtTituloCampo,
                      decoration: InputDecoration(labelText: 'Titulo Campo')),
                  SizedBox(height: 15),
                  _crearList(),
                  _statusUnidad()
                ],
              ),
            ),
            actions: [_agregar()],
          );
        });
  }

  Widget _crearList() {
    return StatefulBuilder(builder: (context, setState) {
      return DropdownButton(
        value: _valorDefecto,
        items: getOpciones(),
        isExpanded: true,
        onChanged: (text) {
          setState(() {
            _valorDefecto = text.toString();
          });
        },
      );
    });
  }

  List<DropdownMenuItem<String>> getOpciones() {
    List<DropdownMenuItem<String>> lista = [];
    _tiposCampos.forEach((opciones) {
      lista.add(DropdownMenuItem(
        child: Text(opciones),
        value: opciones,
      ));
    });
    return lista;
  }

  Widget _statusUnidad() => StatefulBuilder(builder: (context, setState) {
        return SwitchListTile(
            title: Text(
              'Requerido:',
              textAlign: TextAlign.left,
            ),
            value: _requerido,
            onChanged: (val) {
              setState(() {
                _requerido = val;
              });
            });
      });

  _agregar() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            final det = SubFormulario(
              campo: _txtNombreCampo.text,
              titulo: _txtTituloCampo.text,
              requeridoCampo: _requerido,
              tipoCampo: _valorDefecto,
            );
            _detalleSubform.add(det);
            _txtNombreCampo.clear();
            _txtTituloCampo.clear();
          });
        },
        child: Text('Agregar'));
  }

  Widget _listadoDetalle(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: _detalleSubform.length,
          itemBuilder: (context, int i) => _muestraLista(i, context)),
    );
  }

  _muestraLista(int data, context) {
    return Dismissible(
      key: Key(_detalleSubform[data].toString()),
      onDismissed: (direction) {
        setState(() {
          _detalleSubform.removeAt(data);
        });
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          child: ListTile(
            title: Text(_detalleSubform[data].campo),
            subtitle: Row(
              children: [
                Text('Tipo: ' + _detalleSubform[data].tipoCampo),
                SizedBox(
                  width: 15,
                ),
                Text('Requerido: ' +
                    _detalleSubform[data].requeridoCampo.toString()),
              ],
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
