
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {


  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final canCheckBiometrics = ref.watch( canCheckBiometricsProvider );
    final localAuthState = ref.watch( localAuthProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screeen'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed:() {
                  ref.read( localAuthProvider.notifier)
                    .authenticateUser();
              }, 
              child: const Text('Autenticar'),
            ),

              canCheckBiometrics.when(
                data: ( canCheck ) =>  Text('Puede revisar biometricos: $canCheck'), 
                error: (error, _) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
              ),
              //Todo: Feedback del proceso
              const SizedBox(height: 40,),
              const Text('Estaddo del biometrico', style: TextStyle(fontSize: 30)),
              Text('Estaddo $localAuthState', style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}