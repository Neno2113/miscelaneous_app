import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocationAsync = ref.watch( watchLocationProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),

      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text('Ubicacion Actual'),

            userLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, stackTrace) => Text('$error'), 
              loading: () => const CircularProgressIndicator()
            ),

            const SizedBox(height: 30),
            const Text('Seguimiento de ubicacion'),
            watchLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, stackTrace) => Text('$error'), 
              loading: () => const CircularProgressIndicator()
            ),
          ],
        ),
      ),
    );
  }
}