import 'package:miscelaneos_permissions/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgorundTaskKey = 'com.aneldominguez.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgorundTaskKey = 'com.aneldominguez.miscelaneos.fetch-background-pokemon';



@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch ( task ) {
      case fetchBackgorundTaskKey:
        await loadNextPokemon();
      break;
      case fetchPeriodicBackgorundTaskKey:
        await loadNextPokemon();
      break;
      case Workmanager.iOSBackgroundTask:
        print('Workmanager.iOSBackgroundTask');
      break;
    }


    return true;
  
  });
}




Future loadNextPokemon() async {
  
  final localDbRepository = LocalDBRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonsCount() + 1;

  try {
    final ( pokemon, message ) =  await pokemonRepository.getPokemon('$lastPokemonId');

    if( pokemon == null) throw message;

    await localDbRepository.insertPokemon(pokemon);
    print('Pokemon insertado: ${ pokemon.name}');
    
  } catch (e) {
    print(e);
  }


}