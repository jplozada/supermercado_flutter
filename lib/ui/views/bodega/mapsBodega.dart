import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsBodega extends StatefulWidget {
  @override
  _MapsBodegaState createState() => _MapsBodegaState();
}

class _MapsBodegaState extends State<MapsBodega> {
Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(-16.511133, -68.122632);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
        ),
      ),
    );
  }
}