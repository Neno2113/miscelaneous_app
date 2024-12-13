import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class MagnometerScreen extends ConsumerWidget {
  const MagnometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final magnometer$ = ref.watch(magnetometerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnometro'),
        
      ),
      body: Center(
        child: magnometer$.when(
          data: (value) => Text( 
            value.x.toString(),
            style: const TextStyle( fontSize: 30), 
          ), 
          error: (error, stackTrace) => Text('$error'), 
          loading: () =>const CircularProgressIndicator( ),
        ),
      ),
    );
  }
}