import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supermercado_flutter/core/models/productoModel.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:supermercado_flutter/core/models/ventasModel.dart';
import 'package:supermercado_flutter/core/viewmodels/CRUDModelVentas.dart';

class AddVentas extends StatefulWidget {
  @override
  _AddVentasState createState() => _AddVentasState();
}

class _AddVentasState extends State<AddVentas> {
  final _formKey = GlobalKey<FormState>();
  //database
  final databaseReference = Firestore.instance;
  //Datatable
  final _formKey1 = GlobalKey<FormState>();
  String id;
  int codigoBarrasVenta = 0;
  String nombreProdVenta = "";
  double precioUnitarioVenta;
  double sumaTotalVenta = 0; //-------------------
  int cantidadVenta;
  int maxCantidadVenta = 0;
  double subTotalVenta;
  int cantidadFinalVenta = 0;
  Map listaCodigoBarrasVenta = {}; //-------------------
  Map listaProductoVenta = {}; //-------------------
  Map listaPrecioVenta = {}; //-------------------
  Map listaCantidadVenta = {}; //-------------------
  Map listaSubTotalVenta = {}; //-------------------
  //QR
  String _counter, _value = "000";
  Future _qrcode() async {
    _counter = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancel", true, ScanMode.BARCODE);
    setState(() {
      _value = _counter;
      codigoBarrasVenta = int.parse(_value);
      //database
      databaseReference
          .collection("producto")
          .where('codigoProducto', isEqualTo: codigoBarrasVenta)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          //print(f.data);
          //print(codigoBarrasVenta);
          id = f.documentID;
          nombreProdVenta = f.data['nombreProducto'];
          precioUnitarioVenta = double.parse(f.data['preVentaProducto']);
          maxCantidadVenta = f.data['cantidadProducto'];
          setState(() {
            maxCantidadVenta = f.data['cantidadProducto'];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<CRUDModelVentas>(context);
    DateTime fechaVentaUI = DateTime.now();
    Timestamp fechaVenta = Timestamp.now();
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Producto'),
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
                  //
                  Form(
                    key: _formKey1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: _qrcode,
                                child: Text(
                                  "Leer codigo de barras",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Codigo leido",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(codigoBarrasVenta.toString())
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Fecha",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                        "${fechaVentaUI.day}/${fechaVentaUI.month}/${fechaVentaUI.year} - ${fechaVentaUI.hour}:${fechaVentaUI.minute}")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Cantidad ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "- en stock ${maxCantidadVenta}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          validator: (value) {
                                            if (codigoBarrasVenta == -1 ||
                                                codigoBarrasVenta == null ||
                                                nombreProdVenta == null) {
                                              return 'Vuelva a leer el codigo de barras';
                                            } else {
                                              if (value.isEmpty) {
                                                return 'El campo debe estar llenado';
                                              }
                                              if (int.parse(value) >
                                                  maxCantidadVenta) {
                                                return 'Cantidad no disponible';
                                              }
                                            }
                                          },
                                          onSaved: (value) =>
                                              cantidadVenta = int.parse(value)),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: RaisedButton(
                                    child: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey1.currentState.validate()) {
                                          _formKey1.currentState.save();
                                          if (codigoBarrasVenta == -1 ||
                                              codigoBarrasVenta == null) {
                                            print("Codigo invalido");
                                          } else {
                                            //MultiplicacionSubtotal
                                            subTotalVenta =
                                                precioUnitarioVenta *
                                                    cantidadVenta;
                                            listaCodigoBarrasVenta[id] =
                                                codigoBarrasVenta;
                                            listaProductoVenta[id] =
                                                nombreProdVenta;
                                            listaPrecioVenta[id] =
                                                precioUnitarioVenta;
                                            listaCantidadVenta[id] =
                                                cantidadVenta;
                                            listaSubTotalVenta[id] =
                                                subTotalVenta;
                                            //SumaTotal
                                            var values =
                                                listaSubTotalVenta.values;
                                            var result = values.reduce(
                                                (sum, element) =>
                                                    sum + element);
                                            sumaTotalVenta = result;
                                            //Borrar datos
                                            setState(() {
                                              id = null;
                                              codigoBarrasVenta = 0;
                                              nombreProdVenta = null;
                                              precioUnitarioVenta = null;
                                              cantidadVenta = null;
                                              subTotalVenta = null;
                                              maxCantidadVenta = 0;
                                            });
                                          }
                                        }
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "El precio total de la venta es: ${sumaTotalVenta.toStringAsFixed(2).toString()} Bs.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text("Codigo"),
                            ),
                          ],
                          rows: [
                            for (var item in listaCodigoBarrasVenta.values)
                              DataRow(
                                cells: [
                                  DataCell(Text(item.toString())),
                                ],
                              ),
                          ],
                        ),
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text("Producto"),
                            ),
                          ],
                          rows: [
                            for (var item2 in listaProductoVenta.values)
                              DataRow(
                                cells: [
                                  DataCell(Text(item2.toString())),
                                ],
                              ),
                          ],
                        ),
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text("Precio"),
                            ),
                          ],
                          rows: [
                            for (var item3 in listaPrecioVenta.values)
                              DataRow(
                                cells: [
                                  DataCell(
                                      Text("${item3.toStringAsFixed(2)} Bs.")),
                                ],
                              ),
                          ],
                        ),
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text("Cantidad"),
                            ),
                          ],
                          rows: [
                            for (var item4 in listaCantidadVenta.values)
                              DataRow(
                                cells: [
                                  DataCell(Text(item4.toString())),
                                ],
                              ),
                          ],
                        ),
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text("Subtotal"),
                            ),
                          ],
                          rows: [
                            for (var item5 in listaSubTotalVenta.values)
                              DataRow(
                                cells: [
                                  DataCell(
                                      Text("${item5.toStringAsFixed(2)} Bs.")),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: RaisedButton(
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          color: Colors.redAccent,
                          onPressed: () {
                            setState(() {
                              listaCodigoBarrasVenta.remove(id);
                              listaProductoVenta.remove(id);
                              listaPrecioVenta.remove(id);
                              listaCantidadVenta.remove(id);
                              listaSubTotalVenta.remove(id);
                              codigoBarrasVenta = 0;
                              nombreProdVenta = null;
                              precioUnitarioVenta = null;
                              cantidadVenta = null;
                              subTotalVenta = null;
                              maxCantidadVenta = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: RaisedButton(
                          child: Icon(
                            Icons.add_alert,
                            color: Colors.white,
                          ),
                          color: Colors.brown,
                          onPressed: () {
                            //update cantidadProducto
                            databaseReference
                                .collection("producto")
                                .getDocuments()
                                .then((QuerySnapshot snapshot) {
                              snapshot.documents.forEach((d) {
                                maxCantidadVenta = d.data['cantidadProducto'];
                                if (listaCantidadVenta
                                    .containsKey(d.documentID)) {
                                  print(listaCantidadVenta[d.documentID]);
                                  cantidadFinalVenta = maxCantidadVenta -
                                      listaCantidadVenta[d.documentID];
                                  databaseReference
                                      .collection('producto')
                                      .document(d.documentID)
                                      .updateData({
                                    'cantidadProducto': cantidadFinalVenta
                                  });
                                }
                              });
                            });
                            setState(() {
                              maxCantidadVenta = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  //
                  RaisedButton(
                    splashColor: Colors.red,
                    onPressed: () async {
                      //update cantidadProducto
                      databaseReference
                          .collection("producto")
                          .getDocuments()
                          .then((QuerySnapshot snapshot) {
                        snapshot.documents.forEach((d) {
                          maxCantidadVenta = d.data['cantidadProducto'];
                          if (listaCantidadVenta.containsKey(d.documentID)) {
                            print(listaCantidadVenta[d.documentID]);
                            cantidadFinalVenta = maxCantidadVenta -
                                listaCantidadVenta[d.documentID];
                            databaseReference
                                .collection('producto')
                                .document(d.documentID)
                                .updateData(
                                    {'cantidadProducto': cantidadFinalVenta});
                          }
                        });
                      });
                      setState(() {
                        maxCantidadVenta = 0;
                      });
                      //
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await productProvider.addProduct(
                          Ventas(
                            sumaTotalVenta: sumaTotalVenta,
                            listaCodigoBarrasVenta: listaCodigoBarrasVenta,
                            listaProductoVenta: listaProductoVenta,
                            listaPrecioVenta: listaPrecioVenta,
                            listaCantidadVenta: listaCantidadVenta,
                            listaSubTotalVenta: listaSubTotalVenta,
                            fechaVenta: fechaVenta,
                          ),
                        );
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
