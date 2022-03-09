import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mainscreen extends StatefulWidget {
  Mainscreen({Key key}) : super(key: key);
  static const idscreen = "mainScreen";

  @override
  _MainscreenState createState() => _MainscreenState();
}



class _MainscreenState extends State<Mainscreen> {

   Completer<GoogleMapController> _controllerGoogleMap = Completer();

   GoogleMapController newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        centerTitle: true,
      ),
      body: 
      Stack(
        children:[
          GoogleMap(initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;
          },

          ),

        ]
      ),
    );
  }
}