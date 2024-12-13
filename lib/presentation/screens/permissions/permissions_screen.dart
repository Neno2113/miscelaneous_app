

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}


class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final permissions = ref.watch( permissionsProvider );
    final showAds = ref.watch( showAdsProvider );


    return ListView(
      children: [

        CheckboxListTile(
          value: permissions.cameraGranted, 
          title: const Text('Camara'),
          subtitle: Text('${ permissions.camera }'),
          onChanged: ( _ ) {  
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted, 
          title: const Text('Galeria de Photos'),
          subtitle: Text('${ permissions.photoLibrary }'),
          onChanged: ( _ ) {  
            ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted, 
          title: const Text('Location'),
          subtitle: Text('${ permissions.location }'),
          onChanged: ( _ ) {  
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted, 
          title: const Text('Sensors'),
          subtitle: Text('${ permissions.sensors }'),
          onChanged: ( _ ) {  
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.storageGranted, 
          title: const Text('Storage'),
          subtitle: Text('${ permissions.storage }'),
          onChanged: ( _ ) {  
            ref.read(permissionsProvider.notifier).requestStorageAccess();
          },
        ),
        CheckboxListTile(
          value: showAds, 
          title: const Text('Mostrar Ads'),
          subtitle: const Text('Esta opcion muestra y oculta ads'),
          onChanged: ( _ ) {  
            ref.read(showAdsProvider.notifier).toggleAds();
          },
        ),


     
      ],
    );
  }
}