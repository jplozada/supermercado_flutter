import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:supermercado_flutter/core/models/ventasModel.dart';
import 'package:supermercado_flutter/core/viewmodels/CRUDModelVentas.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:supermercado_flutter/ui/views/ventas/pdf_viewer.dart';

class VentasDetails extends StatefulWidget {
  final Ventas product;

  VentasDetails({@required this.product});
  @override
  _VentasDetailsState createState() => _VentasDetailsState();
}

class _VentasDetailsState extends State<VentasDetails> {
  //PDF
  List<Ventas> products;
  bool a0 = false,
      a1 = false,
      a2 = false,
      a3 = false,
      a4 = false,
      a5 = false,
      a6 = false,
      a7 = false,
      a8 = false;
  bool i0 = false,
      i1 = false,
      i2 = false,
      i3 = false,
      i4 = false,
      i5 = false,
      i6 = false;
  PermissionName permissionName = PermissionName.Storage;
  String message = '';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelVentas>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Venta detalle'),
        backgroundColor: Color(0xff2c363f),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await productProvider.removeProduct(widget.product.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
            ),
            onPressed: () {
//              Permission.openSettings();
//              getSinglePermissionStatus(context);
              _getPermissionsStatus();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Fecha: ${widget.product.fechaVenta.toDate().day}/${widget.product.fechaVenta.toDate().month}/${widget.product.fechaVenta.toDate().year} - ${widget.product.fechaVenta.toDate().hour}:${widget.product.fechaVenta.toDate().minute}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "El precio total de la venta fue:",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${widget.product.sumaTotalVenta.toStringAsFixed(2)} Bs.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
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
                              for (var item in widget
                                  .product.listaCodigoBarrasVenta.values)
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
                              for (var item2
                                  in widget.product.listaProductoVenta.values)
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
                              for (var item3
                                  in widget.product.listaPrecioVenta.values)
                                DataRow(
                                  cells: [
                                    DataCell(Text(
                                        "${item3.toStringAsFixed(2)} Bs.")),
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
                              for (var item4
                                  in widget.product.listaCantidadVenta.values)
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
                              for (var item5
                                  in widget.product.listaSubTotalVenta.values)
                                DataRow(
                                  cells: [
                                    DataCell(Text(
                                        "${item5.toStringAsFixed(2)} Bs.")),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _generatePdfAndView(context) async {
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(pdfLib.MultiPage(
        build: (pdfLib.Context context) => <pdfLib.Widget>[
              pdfLib.Row(
                  mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
                  children: <pdfLib.Widget>[
                    pdfLib.Text("Venta ${widget.product.id}"),
                    pdfLib.Text("Venta ${widget.product.fechaVenta.toDate()}"),
                  ]),
              pdfLib.Container(height: 30),
              pdfLib.Center(
                child: pdfLib.Text("Detalle", textScaleFactor: 2),
              ),
              pdfLib.Container(height: 30),
              pdfLib.Row(children: <pdfLib.Widget>[
                pdfLib.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Codigo',
                    ],
                    for (var item1 in widget.product.listaCodigoBarrasVenta.values)
                      <String>[
                        "${item1}",
                      ],
                  ],
                ),
                pdfLib.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Producto',
                    ],
                    for (var item2 in widget.product.listaProductoVenta.values)
                      <String>[
                        "${item2}",
                      ],
                  ],
                ),
                pdfLib.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Precio',
                    ],
                    for (var item3 in widget.product.listaPrecioVenta.values)
                      <String>[
                        "${item3.toStringAsFixed(2)} Bs.",
                      ],
                  ],
                ),
                pdfLib.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Cantidad',
                    ],
                    for (var item4 in widget.product.listaCantidadVenta.values)
                      <String>[
                        "${item4}",
                      ],
                  ],
                ),
                pdfLib.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Sub Total',
                    ],
                    for (var item5 in widget.product.listaSubTotalVenta.values)
                      <String>[
                        "${item5.toStringAsFixed(2)} Bs.",
                      ],
                  ],
                ),
              ]),
              pdfLib.Container(height: 30),
              pdfLib.Text("Precio total ${widget.product.sumaTotalVenta.toStringAsFixed(2)}", textScaleFactor: 1.5),
            ]));

    final dir = (await getExternalStorageDirectory()).path;
    final String path = '$dir/reporte.pdf';
    final File file = File(path);
    print(dir);
    print(path);
    print(file);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }

  _getSinglePermissionStatus(context) async {
    var permissionStatus =
        await Permission.getSinglePermissionStatus(permissionName);
    setState(() {
      message = permissionStatus.toString();
    });
  }

  _getPermissionsStatus() async {
    List<PermissionName> permissionNames = [];

    if (a8 == false) permissionNames.add(PermissionName.Storage);

//    if(i6) permissionNames.add(PermissionName.Storage);
    message = '';
    List<Permissions> permissions =
        await Permission.getPermissionsStatus(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}';
      print("---------------");
      print("message ===>>> " + message);
      if (message.toString() ==
          "PermissionName.Storage: PermissionStatus.notAgain") {
        Permission.openSettings();
      }
      if (message.toString() ==
          "PermissionName.Storage: PermissionStatus.allow") {
        _generatePdfAndView(context);
      }
      print("--------------------------------");
      print("permission is " + message);
    });
  }
}
