


import 'package:miscelaneos_permissions/domain/domain.dart';

abstract class LocalDbRepository {


  Future<List<Pokemon>> loadPokemons();

  Future<int> pokemonsCount();

  Future<void> insertPokemon( Pokemon pokemon);

}