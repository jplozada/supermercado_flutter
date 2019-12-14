import 'package:flutter/material.dart';
import 'package:supermercado_flutter/core/models/ventasModel.dart';
import 'package:supermercado_flutter/core/viewmodels/CRUDModelVentas.dart';
import 'package:supermercado_flutter/ui/views/ventas/ModifyVentas.dart';
import 'package:provider/provider.dart';

class VentasDetails extends StatefulWidget {
  final Ventas product;

  VentasDetails({@required this.product});
  @override
  _VentasDetailsState createState() => _VentasDetailsState();
}

class _VentasDetailsState extends State<VentasDetails> {

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelVentas>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto detalle'),
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
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => ModifyVentas(
              //               product: product,
              //             )));
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        Text("Codigo Venta"),
                        Text(widget.product.sumaTotalVenta.toString())
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
                        Text("Codigo del producto"),
                        Text(widget.product.listaCodigoBarrasVenta.values.toString())
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
                        Text("Nombre Producto"),
                        Text(widget.product.listaProductoVenta.values.toString())
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
                        Text(widget.product.listaPrecioVenta.values.toString())
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
                        Text("Precio Unitario"),
                        Text(widget.product.listaCantidadVenta.values.toString())
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
                        Text("Sub Total"),
                        Text(widget.product.listaSubTotalVenta.values.toString())
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
                        Text("Sub Total"),
                        Text(widget.product.fechaVenta.toDate().toString())
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
