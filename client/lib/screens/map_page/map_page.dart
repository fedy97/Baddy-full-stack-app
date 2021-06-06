import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polimi_app/services/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapPage();
  }
}

class MapPage extends StatefulWidget {
  static String routeName = '/map';

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Utils.loadingWidget();
            return GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition:CameraPosition(
                target: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          },
          future: Utils.determinePosition(context: context),
        ));
  }
}
