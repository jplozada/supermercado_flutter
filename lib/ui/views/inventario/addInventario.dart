import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermercado_flutter/core/models/inventarioModel.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_flutter/core/viewmodels/CRUDModelInventario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddInventario extends StatefulWidget {
  @override
  _AddInventarioState createState() => _AddInventarioState();
}

class _AddInventarioState extends State<AddInventario> {
  final _formKey = GlobalKey<FormState>();
  var botonBodega;
  var botonProducto;
  String codigoInventario;
  String productoInventario;
  String cantidadInventario;
  String fechaElabInventario;
  String fechaExpInventario;
  String bodegaInventario;

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<CRUDModelInventario>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Inventario'),
          backgroundColor: Color(0xff2c363f),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Codigo"),
                                TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'El campo debe estar llenado';
                                      }
                                    },
                                    onSaved: (value) =>
                                        codigoInventario = value),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Producto"),
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('producto')
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData)
                                        Center(
                                          child:
                                              const CupertinoActivityIndicator(),
                                        );
                                      return DropdownButtonFormField<String>(
                                        value: botonProducto,
                                        hint: Text('Producto'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            botonProducto = newValue;
                                            productoInventario = botonProducto;
                                          });
                                        },
                                        validator: (String botonProducto) {
                                          if (botonProducto?.isEmpty ?? true) {
                                            return 'Seleccione el producto';
                                          }
                                        },
                                        items: snapshot.data != null
                                            ? snapshot.data.documents.map(
                                                (DocumentSnapshot document) {
                                                return new DropdownMenuItem<
                                                        String>(
                                                    value: document
                                                        .data['nombreProducto']
                                                        .toString(),
                                                    child: new Container(
                                                      //color: primaryColor,
                                                      child: new Text(
                                                        document.data[
                                                                'nombreProducto']
                                                            .toString(),
                                                      ),
                                                    ));
                                              }).toList()
                                            : DropdownMenuItem(
                                                value: 'null',
                                                child: new Container(
                                                  height: 100.0,
                                                  child: new Text('null'),
                                                ),
                                              ),
                                      );
                                    }),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Cantidad"),
                                TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'El campo debe estar llenado';
                                      }
                                    },
                                    onSaved: (value) =>
                                        cantidadInventario = value),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Fecha elaboracion"),
                                TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'El campo debe estar llenado';
                                      }
                                    },
                                    onSaved: (value) =>
                                        fechaElabInventario = value),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Fecha Expiracion"),
                                TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'El campo debe estar llenado';
                                      }
                                    },
                                    onSaved: (value) =>
                                        fechaExpInventario = value),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Bodega y perchas"),
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('bodega')
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData)
                                        Center(
                                          child:
                                              const CupertinoActivityIndicator(),
                                        );
                                      return DropdownButtonFormField<String>(
                                        value: botonBodega,
                                        hint: Text('bodega'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            botonBodega = newValue;
                                            bodegaInventario = botonBodega;
                                          });
                                        },
                                        validator: (String botonBodega) {
                                          if (botonBodega?.isEmpty ?? true) {
                                            return 'Seleccione la bodega';
                                          }
                                        },
                                        items: snapshot.data != null
                                            ? snapshot.data.documents.map(
                                                (DocumentSnapshot document) {
                                                return new DropdownMenuItem<
                                                        String>(
                                                    value: document
                                                        .data['nombreBodega']
                                                        .toString(),
                                                    child: new Container(
                                                      //color: primaryColor,
                                                      child: new Text(
                                                        document.data[
                                                                'nombreBodega']
                                                            .toString(),
                                                      ),
                                                    ));
                                              }).toList()
                                            : DropdownMenuItem(
                                                value: 'null',
                                                child: new Container(
                                                  height: 100.0,
                                                  child: new Text('null'),
                                                ),
                                              ),
                                      );
                                    }),
                              ],
                            ),
                          )),
                    ],
                  ),
                  RaisedButton(
                    splashColor: Colors.red,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await productProvider.addProduct(Inventario(
                          codigoInventario: int.parse(codigoInventario),
                          productoInventario: productoInventario,
                          cantidadInventario: int.parse(cantidadInventario),
                          fechaElabInventario: fechaElabInventario,
                          fechaExpInventario: fechaExpInventario,
                          bodegaInventario: bodegaInventario,
                        ));
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Registrar',
                        style: TextStyle(color: Colors.white)),
                    color: Color(0xff2c363f),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
