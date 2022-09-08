import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  static const sourceLocation = LatLng(20.979608, 105.782894);
  static const destination = LatLng(21.020038, 105.837766);
  List<LatLng> polyLineCoordinates = [];
  LocationData? currentLocation;
  LocationData? startLocation;
  final Mode _mode = Mode.overlay;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final List<Marker> listMarker = [];
  final CameraPosition _kGooglePlex = const CameraPosition(target: sourceLocation, zoom: 12.4746);

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();
    currentLocation = await location.getLocation();
    listMarker.add(Marker(
        markerId: MarkerId("currrent"),
        position:
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!)));
    listMarker.add(
        const Marker(markerId: MarkerId("destination"), position: destination));
    getPolylineCoordinates();
    setState(() {});


    location.onLocationChanged.listen((newLocaltion) {
      currentLocation = newLocaltion;
      // getPolylineCoordinates();
      setState(() {
        listMarker[0] = Marker(
            markerId: MarkerId("currrent"),
            position: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!));
      });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (currentLocation == null)
          ? const Center(child: Text("Loading"))
          : Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 13.5),
                markers: listMarker.toSet(),
                polylines: {
                  Polyline(
                      polylineId: PolylineId("polylineId"),
                      points: polyLineCoordinates,
                      color: Colors.lightBlueAccent,
                      width: 4),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
              top: 32, left: 20 ,child:
              ElevatedButton(
                  onPressed: _handlePressButton,
                  child: const Text("Search Places")))
            ]),
    );
  }

  Future<void> _handlePressButton() async {
    place.Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyDgr2Wp6QZ79sHfNvnOiNdMYjtrNyXcq6U',
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          place.Component(place.Component.country, "vi"),
          place.Component(place.Component.country, "usa")
        ]);
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(place.PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState!
    //     .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      place.Prediction p, ScaffoldState? currentState) async {
    place.GoogleMapsPlaces places = place.GoogleMapsPlaces(
        apiKey: 'AIzaSyDgr2Wp6QZ79sHfNvnOiNdMYjtrNyXcq6U',
        apiHeaders: await const GoogleApiHeaders().getHeaders());
    place.PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    listMarker.add(Marker(
        markerId: MarkerId(detail.result.placeId), position: LatLng(lat, lng)));
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }
}
