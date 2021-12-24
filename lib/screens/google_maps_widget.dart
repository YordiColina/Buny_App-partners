import 'dart:async';

import 'package:buny_app/model/negocio.dart';
import 'package:buny_app/screens/perfil_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo_code;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsWidget extends StatefulWidget {
  final Negocio negocio;
  const GoogleMapsWidget(this.negocio, {Key? key}) : super(key: key);

  @override
  _GoogleMapsWidgetState createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  Location location = Location();
  CameraPosition? currentLocation; 
  LocationData? currentLocationData;
  final Map<String, Marker> _markers = {};
  List<geo_code.Placemark>? placemarks;

  static const CameraPosition _bogota = CameraPosition(
    target: LatLng(4.651021, -74.087219),
    zoom: 12
  );


  Future<void> setLocation() async {
    currentLocationData = await location.getLocation();
    Marker marker = Marker(
      markerId: const MarkerId('Current_Address'),
      position: LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!),
    );
    _markers['Current_Address'] = marker;

    currentLocation = CameraPosition(
        zoom: 18,
        target: LatLng(
            currentLocationData!.latitude!,
            currentLocationData!.longitude!)
    );

  }

  agregarDireccion() async {
    LatLng coordinates = _markers['Current_Address']!.position;
    placemarks = await geo_code.placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    widget.negocio.direccion = placemarks![0].street!;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return perfil_screen(negocio: widget.negocio);
    }));
  }

  CameraPosition mainLocation(){
    Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        if(currentLocationData ==null){
          setLocation();
        } else {
          currentLocationData = currentLocationData;
        }
      });
    });
    return _bogota;
  }

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: currentLocation==null ? mainLocation()
              : currentLocation!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                if(currentLocation!=null){
                  controller.moveCamera(CameraUpdate.newCameraPosition(currentLocation!)
                  );
                }
              },
              markers: _markers.values.toSet(),
              onCameraMove:(position) {
                setState(() {
                  _markers['Current_Address'] = _markers['Current_Address']!.copyWith(
                      positionParam: position.target,
                  );
                });
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: agregarDireccion,
        label: const Text('Agregar dirección'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}