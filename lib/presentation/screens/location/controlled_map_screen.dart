import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final watchUserLocation = ref.watch( watchLocationProvider);
    final userInitialLocation = ref.watch( userLocationProvider );

    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControls(latitude: data.$1, longitud: data.$2,), 
        error: (error, stackTrace) => Text('$error'), 
        loading: () => const Center( child: Text('Ubicando al usuario'),)
      ),
    );
  }
}


class MapAndControls extends ConsumerWidget {

  final double latitude;
  final double longitud;

  const MapAndControls({super.key, required this.latitude, required this.longitud});

  @override
  Widget build(BuildContext context,WidgetRef ref ) {

    final mapControllerState = ref.watch( mapControllerProvider );

    return Stack(
      children: [
        
        _MapView(initialLat: latitude, initialLng: longitud),

        // ! Boton para salir
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () => context.pop(), 
            icon: const Icon( Icons.arrow_back)
          )
        ),

         // ! ir a la posicion del usuario
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
               ref.read( mapControllerProvider.notifier)
                .findUser();
            }, 
            icon: const Icon( Icons.location_searching_rounded)
          )
        ),

         // ! Seguir usuario
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed:() {
              ref.read( mapControllerProvider.notifier)
                .toggleFollowUser();
              
            }, 
            icon:  
            Icon( 
              mapControllerState.followUser
              ? Icons.directions_run_outlined
              : Icons.accessibility
              
            )
          )
        ),

        
         // ! Crear Marcador
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed:() {
              ref.read(mapControllerProvider.notifier)
                .addMarkerCurrentPosition();
            }, 
            icon: const Icon( Icons.pin_drop)
          )
        ),

      ],
    );
  }
}


class _MapView extends ConsumerStatefulWidget {

  final double initialLat;
  final double initialLng;

  const _MapView({ 
    required this.initialLat, 
    required this.initialLng
  });

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {


  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch( mapControllerProvider);


    return GoogleMap(
      markers: mapController.markersSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng( widget.initialLat, widget.initialLng),
        zoom: 15,
        
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
        ref.read( mapControllerProvider.notifier)
          .setMapController(controller);

      },
      onLongPress: (latLn) {
        ref.read( mapControllerProvider.notifier)
          .addmarker(latLn.latitude, latLn.longitude, 'Im here');
      },
      // onTap: ,
    );
  }
}