import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo_code;

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({Key? key}) : super(key: key);

  @override
  _GoogleMapsWidgetState createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  Location location = Location();
  CameraPosition? currentLocation; 
  LocationData? currentLocationData;
  final Map<String, Marker> _markers = {};

  static const CameraPosition _bogota = CameraPosition(
    target: LatLng(4.651021, -74.087219),
    zoom: 12
  );

  Future<CameraPosition> setLocation() async {
    currentLocationData = await location.getLocation();
    List<geo_code.Placemark> placemarks = await geo_code.placemarkFromCoordinates(currentLocationData!.latitude!, currentLocationData!.longitude!);
    Marker marker = Marker(
        markerId: const MarkerId('Current_Address'),
        position: LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!),
        infoWindow: InfoWindow(
            title: 'Nombre del negocio',
            snippet: placemarks[0].street,
        ),
    );
    _markers['Current_Address'] = marker;

    return CameraPosition(
        zoom: 18,
        target: LatLng(
            currentLocationData!.latitude!,
            currentLocationData!.longitude!)
    );
    /**final GoogleMapController controller = await _controller.future;
    setState(() {

      controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 18,
                  target: LatLng(
                      currentLocationData!.latitude!,
                      currentLocationData!.longitude!)
              )
          )
      );
    });*/

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: setLocation(),
          builder: (ctx, AsyncSnapshot<CameraPosition> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: const TextStyle(fontSize: 18),
              ),
            );
          }else if(snapshot.hasData){
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: snapshot.data!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.values.toSet(),
            );
        }
        } return const CircularProgressIndicator();
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: const Text('Agregar dirección'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}