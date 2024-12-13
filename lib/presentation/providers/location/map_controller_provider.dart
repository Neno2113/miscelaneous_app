// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapstate {
  
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  Mapstate({
    this.isReady = false, 
    this.followUser = false, 
    this.markers = const[], 
    this.controller
  });

  Set<Marker> get markersSet {
    return Set.from(markers);

  }



  Mapstate copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) => Mapstate(
    isReady: isReady ?? this.isReady,
    followUser: followUser ?? this.followUser,
    markers: markers ?? this.markers,
    controller: controller ?? this.controller,
  );
  
}



class MapNotifier extends StateNotifier<Mapstate> {

  StreamSubscription? userLocation$;
  (double, double)? lastKnowmLocation;

  MapNotifier(): super( Mapstate() ){
    trackUser().listen((event) {
      lastKnowmLocation = (event.$1, event.$2);
    });
  }


  Stream<(double, double)> trackUser() async* {
    await for( final pos in Geolocator.getPositionStream()){
      yield(pos.latitude, pos.longitude);
    }
  }


  void setMapController( GoogleMapController controller ){
    state = state.copyWith(controller: controller, isReady: true);
  }

  goToLocation( double latitude, double longitud ) {
    final newPosition = CameraPosition(
      target: LatLng( latitude, longitud ),
      zoom: 15
    );
    state.controller?.animateCamera( CameraUpdate.newCameraPosition( newPosition ));
  }

  toggleFollowUser(){
    state = state.copyWith( followUser: !state.followUser);


    if( state.followUser ){
      findUser();
      userLocation$ = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocation$?.cancel();
    }

  }

  findUser(){
    if( lastKnowmLocation == null ) return;
    final (latitude, longitud) = lastKnowmLocation!;
    goToLocation(latitude, longitud);
    // trackUser().take(1).listen((event) {
    //   goToLocation(event.$1, event.$2);
    // });
  }

  void addMarkerCurrentPosition( ){
    if( lastKnowmLocation == null ) return;

    final( latitude, longitud ) = lastKnowmLocation!;
    addmarker(latitude, longitud, 'Por aqui paso el usuario');
  }

  void addmarker(double latitude, double longitud, String name ){
    
    final newMarker = Marker(
      markerId: MarkerId('${ state.markers.length }'),
      position: LatLng(latitude, longitud),
      infoWindow: InfoWindow(
        title: name,
        snippet: 'Esto es el snippet del curstom wndows'
      )
    );

    state = state.copyWith( markers: [...state.markers, newMarker]);
  }

}


final mapControllerProvider = StateNotifierProvider.autoDispose<MapNotifier, Mapstate>((ref) {
  return MapNotifier();
});
