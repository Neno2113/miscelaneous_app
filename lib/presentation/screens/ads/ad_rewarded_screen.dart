import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final adRewardedAsync = ref.watch(adReawardedProvider);
    final appPoints = ref.watch(appPointsProvider);


    ref.listen(adReawardedProvider, (previous, next) { 
      if( !next.hasValue) return;
      if( next.value == null) return;

      next.value!.show(onUserEarnedReward:(ad, reward) {
        ref.read(appPointsProvider.notifier).update((state) => state + 10);
        },
      );

    });

    if( adRewardedAsync.isLoading ) {
      return const Scaffold(
        body: Center(
          child: Text('Cargando Anuncio'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Rewearded'),
      ),

      body:  Center(
        child: Text('Puntos Actuales: $appPoints'),
      ),
    );
  }
}