import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class Direction extends StatefulWidget {
  const Direction({ Key? key }) : super(key: key);

  @override
  State<Direction> createState() => _DirectionState();
}


class _DirectionState extends State<Direction> {
 static LatLng? currentLatLng=null;
  
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState(){
    super.initState();
    Geolocator.getCurrentPosition().then((currLocation){
      setState((){
        currentLatLng =new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
    // destinationPointLat();destinationPointLong();
  }
  static final Marker Omarker =Marker(
    markerId: MarkerId("Origin"),
    infoWindow: InfoWindow(title: "Origin"),
    icon: BitmapDescriptor.defaultMarker,
    position:currentLatLng!);
     static final Marker Dmarker =Marker(
    markerId: MarkerId("Destination"),
    infoWindow: InfoWindow(title: "Destination"),
    icon: BitmapDescriptor.defaultMarkerWithHue(50),
    position:LatLng(18.456628899151177,73.84889009935323));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  currentLatLng == null ? Center(child:CircularProgressIndicator())
        : GoogleMap(
          mapType: MapType.normal,
          markers: {Omarker,Dmarker},
          initialCameraPosition: CameraPosition(target: currentLatLng!),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
    );
  }
  //   static  Future destinationPointLong()async{
  //    double dlat=0.0;
  //    CollectionReference user1=FirebaseFirestore.instance.collection("user1");
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: user1.doc("mess1").get(),
  //     builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
      
  //       if(snapshot.connectionState==ConnectionState.done){
  //         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //         return data['longitude'];}
  //       return const CircularProgressIndicator();
  // });
  // }
  // static destinationPointLat()async{
  //    CollectionReference user1=FirebaseFirestore.instance.collection("user1");
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: user1.doc("mess1").get(),
  //     builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
  //       if(snapshot.hasError){
  //         return Text("Something went wrong");
  //       }
  //       if(snapshot.hasData&& !snapshot.data!.exists){
  //         return Text("Document doesm't exist");
  //       }
  //       if(snapshot.connectionState==ConnectionState.done){
  //         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //         return data['latitude'];}
  //         return const CircularProgressIndicator();
  // });
  // }
}
