import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supermercado_flutter/ui/views/cliente/addCliente.dart';
import 'package:supermercado_flutter/ui/views/cliente/clienteDetails.dart';
import 'package:supermercado_flutter/ui/views/cliente/readCliente.dart';
import 'package:supermercado_flutter/ui/views/homeView.dart';
import 'package:supermercado_flutter/ui/views/proveedor/addProveedor.dart';
import 'package:supermercado_flutter/ui/views/proveedor/proveedorDetails.dart';
import 'package:supermercado_flutter/ui/views/proveedor/readProveedor.dart';
import 'package:supermercado_flutter/ui/views/usuario/addUsuario.dart';
import 'package:supermercado_flutter/ui/views/usuario/usuarioDetails.dart';
import 'package:supermercado_flutter/ui/views/usuario/readUsuario.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> HomeView()
        );
      case '/readCliente' :
        return  MaterialPageRoute(
          builder: (_)=> ReadCliente()
        );
      case '/addCliente' :
        return MaterialPageRoute(
          builder: (_)=> AddCliente()
        ) ;
      case '/clienteDetails' :
        return MaterialPageRoute(
            builder: (_)=> ClienteDetails()
        ) ;
      case '/readUsuario' :
        return  MaterialPageRoute(
          builder: (_)=> ReadUsuario()
        );
      case '/addUsuario' :
        return MaterialPageRoute(
          builder: (_)=> AddUsuario()
        ) ;
      case '/usuarioDetails' :
        return MaterialPageRoute(
            builder: (_)=> UsuarioDetails()
        ) ;
      case '/readProveedor' :
        return  MaterialPageRoute(
          builder: (_)=> ReadProveedor()
        );
      case '/addProveedor' :
        return MaterialPageRoute(
          builder: (_)=> AddProveedor()
        ) ;
      case '/proveedorDetails' :
        return MaterialPageRoute(
            builder: (_)=> ProveedorDetails()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}