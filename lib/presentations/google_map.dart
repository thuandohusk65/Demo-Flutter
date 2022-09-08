import 'dart:async';
import 'dart:developer';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_api_headers/google_api_headers.dart';

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
  LocationData? startLocation;
  final Mode _mode = Mode.overlay;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

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
    setState(() {});

    // GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocaltion) {
      currentLocation = newLocaltion;
      // getPolylineCoordinates();
      setState(() {});
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
          ? Center(child: Text("Loading"))
          : Stack(children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
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
              ElevatedButton(
                  onPressed: _handlePressButton,
                  child: const Text("Search Places"))
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
          place.Component(place.Component.country, "pk"),
          place.Component(place.Component.country, "usa")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(place.PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      place.Prediction p, ScaffoldState? currentState) async {
    place.GoogleMapsPlaces places = place.GoogleMapsPlaces(
        apiKey: 'AIzaSyDgr2Wp6QZ79sHfNvnOiNdMYjtrNyXcq6U',
        apiHeaders: await const GoogleApiHeaders().getHeaders());
    place.PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId!);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
