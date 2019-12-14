
import 'package:cloud_firestore/cloud_firestore.dart';

class Ventas {
  String id;
  double sumaTotalVenta;
  Map listaCodigoBarrasVenta = {};
  Map listaProductoVenta = {};
  Map listaPrecioVenta = {};
  Map listaCantidadVenta = {};
  Map listaSubTotalVenta = {};
  Timestamp fechaVenta;

  Ventas({this.id, this.sumaTotalVenta, this.listaCodigoBarrasVenta,this.listaProductoVenta,this.listaPrecioVenta,this.listaCantidadVenta,this.listaSubTotalVenta,this.fechaVenta});

  Ventas.fromMap(Map snapshot,String id) :
        id = id ?? '',
        sumaTotalVenta = snapshot['sumaTotalVenta'] ?? '',
        listaCodigoBarrasVenta = snapshot['listaCodigoBarrasVenta'] ?? '',
        listaProductoVenta = snapshot['listaProductoVenta'] ?? '',
        listaPrecioVenta = snapshot['listaPrecioVenta'] ?? '',
        listaCantidadVenta = snapshot['listaCantidadVenta'] ?? '',
        listaSubTotalVenta = snapshot['listaSubTotalVenta'] ?? '',
        fechaVenta = snapshot['fechaVenta'] ?? '';

  toJson() {
    return {
      "sumaTotalVenta": sumaTotalVenta,
      "listaCodigoBarrasVenta": listaCodigoBarrasVenta,
      "listaProductoVenta": listaProductoVenta,
      "listaPrecioVenta": listaPrecioVenta,
      "listaCantidadVenta": listaCantidadVenta,
      "listaSubTotalVenta": listaSubTotalVenta,
      "fechaVenta": fechaVenta,
    };
  }
}