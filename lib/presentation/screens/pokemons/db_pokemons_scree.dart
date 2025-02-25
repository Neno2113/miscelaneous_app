import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_permissions/config/config.dart';
import 'package:miscelaneos_permissions/domain/domain.dart';
import 'package:miscelaneos_permissions/presentation/providers/background_tasks/background_tasks_provider.dart';
import 'package:miscelaneos_permissions/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';





class DBPokemonsScreen extends ConsumerWidget {
  const DBPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final pokemonsAsync = ref.watch( pokemonDBProvider );
    final isBackgroundFetchActive = ref.watch( backgroundPokemonFetchProvider );


    if( pokemonsAsync.isLoading ) {
        return const Scaffold( 
        body: Center( 
          child: CircularProgressIndicator(),
        ),
      );
    }


    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Backgroun Process'),
        actions: [
          IconButton(
            onPressed: () {
              Workmanager().registerOneOffTask(
                fetchBackgorundTaskKey, 
                fetchBackgorundTaskKey,
                initialDelay:  const Duration( seconds: 3),
                inputData: { 'howMany': 30 }
              );
            }, 
            icon: const Icon( Icons.add_alert_sharp)
          ),
        ],
      ),
      body:  CustomScrollView(
        slivers: [
          _PokemonsGrid( pokemons: pokemons )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read( backgroundPokemonFetchProvider.notifier ).toggleProcess();

        
        }, 
        label:( isBackgroundFetchActive == true ) 
          ? const Text('Desactivar Fetch Periodico')
          : const Text('Activar Fetch Periodico'),
        icon: const Icon( Icons.av_timer ),
      ),
    );
  }
}


class _PokemonsGrid extends StatelessWidget {

  final List<Pokemon> pokemons;

  const _PokemonsGrid({ required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2
      ), 
      itemCount: pokemons.length,
      itemBuilder: (context, index) {

        final pokemon = pokemons[index];

        return Column(
          children: [
            Image.network(
              pokemon.spriteFront,
              fit: BoxFit.contain,
            ),
            Text( pokemon.name )
          ],
        );

      },
    );
  }
}