import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  static const sourceLocation = LatLng(20.979608, 105.782894);
  static const destination = LatLng(21.020038, 105.837766);
  List<LatLng> polyLineCoordinates = [];
  LocationData? currentLocation;

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: sourceLocation, zoom: 12.4746);

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();
    currentLocation = await location.getLocation();
    getPolylineCoordinates();
    // setState(() {});

    // GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocaltion) {
      currentLocation = newLocaltion;
      getPolylineCoordinates();
      // setState(() {});
      log('====currentlocation ${currentLocation!.latitude!} ${currentLocation!.longitude!}');
      // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target:
      //             LatLng(newLocaltion.latitude!, newLocaltion.longitude!)
      //             , zoom: 15.5
      //     ))
      // );
    });
  }

  void getPolylineCoordinates() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDgr2Wp6QZ79sHfNvnOiNdMYjtrNyXcq6U",
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(destination.latitude, destination.longitude));
    log('====result: ${result.errorMessage}');
    if (result.points.isNotEmpty) {
      result.points.forEach((element) =>
          polyLineCoordinates.add(LatLng(element.latitude, element.longitude)));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (currentLocation == null)
          ? Center(child: Text("Loading"))
          : GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 13.5),
              markers: {
                Marker(
                    markerId: MarkerId("source"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!)),
                Marker(
                    markerId: const MarkerId("destination"),
                    position: destination)
              },
              polylines: {
                Polyline(
                    polylineId: PolylineId("polylineId"),
                    points: polyLineCoordinates,
                    color: Colors.lightBlueAccent,
                    width: 3),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
