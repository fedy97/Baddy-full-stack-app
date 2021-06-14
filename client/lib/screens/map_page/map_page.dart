import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/profile/profile_page.dart';
import 'package:polimi_app/services/utils.dart';
import 'package:provider/provider.dart';

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
    Set<Marker> markers = Set<Marker>.of(_toMarker(context).values);
    return new Scaffold(
        body: FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Utils.loadingWidget();
        return GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(snapshot.data.latitude, snapshot.data.longitude),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers,
        );
      },
      future: Utils.determinePosition(context: context),
    ));
  }

  static Map<MarkerId, Marker> _toMarker(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    Map<MarkerId, Marker> map = Map();
    for (var i = 0; i < model.availableUsers.length; i++) {
      var curr = model.availableUsers[i];
      if (curr.lat != null && curr.long != null) {
        final markerId =
            MarkerId(model.availableUsers.indexOf(curr).toString());
        //color marker if fined
        final Marker marker = Marker(
            icon: BitmapDescriptor.defaultMarker,
            onTap: () async {
              model.setSelectedUser(curr);
              await Navigator.pushNamed(context, ProfilePage.routeName);
              model.selectedUser.reviewsAboutMe = null;
              model.setSelectedUser(null);
            },
            markerId: markerId,
            position: LatLng(curr.lat, curr.long));
        map[markerId] = marker;
      }
    }
    return map;
  }
}
