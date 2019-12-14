import 'package:flutter/material.dart';
import 'package:supermercado_flutter/core/models/bodegaModel.dart';
import 'package:supermercado_flutter/core/viewmodels/CRUDModelBodega.dart';
import 'package:supermercado_flutter/ui/views/bodega/ModifyBodega.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_flutter/ui/views/bodega/mapsBodega.dart';

class BodegaDetails extends StatelessWidget {
  final Bodega product;

  BodegaDetails({@required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelBodega>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bodega detalle'),
        backgroundColor: Color(0xff2c363f),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await productProvider.removeProduct(product.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ModifyBodega(
                            product: product,
                          )));
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
                        Text(
                          "Nombre:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(product.nombreBodega)
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
                        Text(
                          "Ubicacion:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),                        Text(product.ubicacionBodega)
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
                                                Text(
                          "Descripcion:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(product.descripcionBodega)
                      ],
                    ),
                  )),
            ],
          ),
          Container(height: 20,),
          Container(
            width: double.infinity,
            height: 300,
            child: MapsBodega(),
          )
        ],
      ),
    );
  }
}
