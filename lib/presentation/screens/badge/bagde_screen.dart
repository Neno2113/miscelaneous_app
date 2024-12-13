import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/config/config.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final badgeCounter = ref.watch( badgeCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Badge'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Badge( 
              label: Text('$badgeCounter'),
              alignment: Alignment.lerp(Alignment.topRight, Alignment.bottomRight, 0.2),
              child: Text('$badgeCounter', style: const TextStyle( fontSize: 150),),
            ),

            FilledButton.tonal(
              onPressed: () {
                ref.invalidate(badgeCounterProvider);
              }, 
              child: const Text('Borrar Badge')
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read( badgeCounterProvider.notifier).update((state) => state + 1);
          AppBagdeplugin.updateBadgeCount( badgeCounter + 1);
        },
        child: const Icon( Icons.plus_one),
      ),
    );
  }
}