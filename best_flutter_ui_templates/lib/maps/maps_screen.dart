// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:best_flutter_ui_templates/navigation_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/themes/app_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  GeoPoint haritaKonum;

  MapsScreen({
    Key? key,
    required this.haritaKonum,
  }) : super(key: key);
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> mapController = Completer();
  late GeoPoint haritaKonumu = widget.haritaKonum;

  void onMapCreated(GoogleMapController controller) {
    mapController;
  }

  Set<Marker> getMarker() {
    final Set<Marker> marker = new Set();
    marker.add(Marker(
      markerId: MarkerId('Konum'),
      infoWindow: InfoWindow(title: 'Konum'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(haritaKonumu.latitude, haritaKonumu.longitude),
    ));
    return marker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              markers: getMarker(),
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(haritaKonumu.latitude, haritaKonumu.longitude),
                  zoom: 14.4746),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                IconButton(
                    iconSize: 70,
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    NavigationHomeScreen(user: user)),
                            (Route<dynamic> route) => false);
                      }
                    },
                    icon: Image.asset("assets/helimore_app/tab_4.png")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
